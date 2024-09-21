import 'dart:convert';
import 'package:price_app/features/utils/exports.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _secureStorage = const FlutterSecureStorage();
  final String publicKey = 'FLWPUBK-a4dd6db1eaf634be117d5440ae234b61-X';
  final String secretKey = 'FLWSECK-a5885510edd1892f8f569996d8715ddb-19206a65e56vt-X';
  String? transactionId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserAndCart();
    });
  }

  Future<void> _loadUserAndCart() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    String? userId = await _secureStorage.read(key: 'userId');
    await userProvider.fetchUserProfile(userId!);
    await cartProvider.fetchCartData();
  }

  Future<void> _handlePayment(double amount, User user, List<dynamic> cartBooks) async {
    final amountInKobo = (amount * 100).toInt();

    // Create a payment payload
    final payload = {
      "tx_ref": "hooli-tx-1920bbtytty",
      "amount": amountInKobo,
      "currency": "NGN",
      "redirect_url": "https://www.google.com",
      "meta": {
        "consumer_id": 23,
        "consumer_mac": "92a3-912ba-1192a"
      },
      "customer": {
        "email": user.email,
        "phonenumber": user.phoneNumber,
        "name": "${user.firstName} ${user.lastName}"
      },
      "customizations": {
        "title": "Parchment Payment",
        "logo": "https://assets.piedpiper.com/logo.png"
      }
    };

    try {
      final response = await http.post(
        Uri.parse('https://api.flutterwave.com/v3/payments'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final paymentLink = responseData['data']['link'];
        transactionId = responseData['data']['id'].toString();

        if (await canLaunchUrl(Uri.parse(paymentLink))) {
          await launchUrl(Uri.parse(paymentLink),mode:LaunchMode.externalApplication);
          // After redirecting, handle the process to check if payment is complete
          await _checkPaymentStatus();
        } else {
          throw 'Could not launch payment link';
        }
      } else {
        throw 'Failed to initiate payment';
      }
    } catch (e) {
      _showMessage("An error occurred: $e", isError: true);
    }
  }

  Future<void> _checkPaymentStatus() async {
    if (transactionId == null) {
      _showMessage("Transaction ID not found", isError: true);
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('https://api.flutterwave.com/v3/transactions/$transactionId/verify'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success' &&
            responseData['data']['status'] == 'successful') {
          _onPaymentSuccess();
        } else {
          _showMessage("Payment was not completed. Please try again.", isError: true);
        }
      } else {
        throw 'Failed to verify payment';
      }
    } catch (e) {
      _showMessage("An error occurred while verifying payment: $e", isError: true);
    }
  }

  void _onPaymentSuccess() {
    _showMessage("Payment Successful!");
    _addBooksToLibraryInBackground();
  }

  void _addBooksToLibraryInBackground() {
    Future.microtask(() async {
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      final bookProvider = Provider.of<BookProvider>(context, listen: false);
      final cartBooks = cartProvider.cartBooks;

      for (var cartItem in cartBooks) {
        try {
          await bookProvider.addBookToLibrary(cartItem['bookId']['_id']);
        } catch (e) {
          print("Failed to add book ${cartItem['bookId']['title']} to library: $e");
        }
      }

      await cartProvider.clearCart();
      Navigator.pushNamed(context, '/library');
    });
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        return Consumer<CartProvider>(
          builder: (context, cartProvider, _) {
            final user = userProvider.user;
            final cartBooks = cartProvider.cartBooks;

            if (user == null || cartBooks.isEmpty) {
              return Scaffold(
                appBar: AppBar(title: const Text("Payment")),
                body: const Center(child: CircularProgressIndicator(color: Color(0xFF0B6F17))),
              );
            }

            return Scaffold(
              appBar: AppBar(
                  backgroundColor: const Color(0xFF0B6F17),
                  elevation: 200,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pushReplacementNamed('/cart_zero'),
                  ),
                  title: const Text(
                    "Payment",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Payment Details:', style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 10),
                    Text('Name: ${user.firstName} ${user.lastName}'),
                    Text('Email: ${user.email}'),
                    Text('Phone: ${user.phoneNumber}'),
                    const SizedBox(height: 20),
                    Text('Cart Items:', style: Theme.of(context).textTheme.titleMedium),
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartBooks.length,
                        itemBuilder: (context, index) {
                          final book = cartBooks[index]['bookId'];
                          return ListTile(
                            title: Text(book['title']),
                            subtitle: Text('Price: ₦${book['price']}'),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                        'Total Amount: ₦${cartProvider.calculateTotal().toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.headlineMedium
                    ),
                    const SizedBox(height: 20),
                    MyElevatedButton(
                      buttonText: 'Make Payment',
                      onPressed: () {
                        _handlePayment(
                          cartProvider.calculateTotal(),
                          user,
                          cartBooks,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}









// import 'package:price_app/features/utils/exports.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({Key? key}) : super(key: key);
//
//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }
//
// class _PaymentScreenState extends State<PaymentScreen> {
//   final _secureStorage = const FlutterSecureStorage();
//   final String basePaymentLink = "https://flutterwave.com/pay/mdmo28zxchw9"; // Base payment link
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _loadUserAndCart();
//     });
//   }
//
//   Future<void> _loadUserAndCart() async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     final cartProvider = Provider.of<CartProvider>(context, listen: false);
//
//     String? userId = await _secureStorage.read(key: 'userId');
//     await userProvider.fetchUserProfile(userId!);
//     await cartProvider.fetchCartData();
//   }
//
//   Future<void> _handlePayment(double amount, User user, List<dynamic> cartBooks) async {
//     // Construct the payment URL with dynamic parameters
//     final dynamicPaymentLink = "$basePaymentLink"
//         "?amount=$amount"
//         "&customer_email=${Uri.encodeComponent(user.email)}"
//         "&customer_firstname=${Uri.encodeComponent(user.firstName)}"
//         "&customer_lastname=${Uri.encodeComponent(user.lastName)}";
//
//     try {
//       if (await canLaunch(dynamicPaymentLink)) {
//         await launch(dynamicPaymentLink);
//         // After redirecting, handle the process to check if payment is complete
//         _onPaymentSuccess();
//       } else {
//         throw 'Could not launch payment link';
//       }
//     } catch (e) {
//       _showMessage("An error occurred: $e", isError: true);
//     }
//   }
//
//   void _onPaymentSuccess() {
//     // Handle successful payment
//     _showMessage("Payment Successful!");
//     _addBooksToLibraryInBackground();
//   }
//
//   void _addBooksToLibraryInBackground() {
//     Future.microtask(() async {
//       final cartProvider = Provider.of<CartProvider>(context, listen: false);
//       final bookProvider = Provider.of<BookProvider>(context, listen: false);
//       final cartBooks = cartProvider.cartBooks;
//
//       for (var cartItem in cartBooks) {
//         try {
//           await bookProvider.addBookToLibrary(cartItem['bookId']['_id']);
//         } catch (e) {
//           print("Failed to add book ${cartItem['bookId']['title']} to library: $e");
//         }
//       }
//
//       await cartProvider.clearCart();
//       Navigator.pushNamed(context, '/library');
//     });
//   }
//
//   void _showMessage(String message, {bool isError = false}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError ? Colors.red : Colors.green,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<UserProvider>(
//       builder: (context, userProvider, _) {
//         return Consumer<CartProvider>(
//           builder: (context, cartProvider, _) {
//             final user = userProvider.user;
//             final cartBooks = cartProvider.cartBooks;
//
//             if (user == null || cartBooks.isEmpty) {
//               return Scaffold(
//                 appBar: AppBar(title: const Text("Payment")),
//                 body: const Center(child: CircularProgressIndicator(color: Color(0xFF0B6F17))),
//               );
//             }
//
//             return Scaffold(
//               appBar: AppBar(
//                   backgroundColor: const Color(0xFF0B6F17),
//                   elevation: 200,
//                   leading: IconButton(
//                     icon: const Icon(Icons.arrow_back, color: Colors.white),
//                     onPressed: () => Navigator.of(context).pushReplacementNamed('/cart_zero'),
//                   ),
//                   title: const Text(
//                     "Payment",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   )
//               ),
//               body: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Payment Details:', style: Theme.of(context).textTheme.headlineMedium),
//                     const SizedBox(height: 10),
//                     Text('Name: ${user.firstName} ${user.lastName}'),
//                     Text('Email: ${user.email}'),
//                     Text('Phone: ${user.phoneNumber}'),
//                     const SizedBox(height: 20),
//                     Text('Cart Items:', style: Theme.of(context).textTheme.titleMedium),
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: cartBooks.length,
//                         itemBuilder: (context, index) {
//                           final book = cartBooks[index]['bookId'];
//                           return ListTile(
//                             title: Text(book['title']),
//                             subtitle: Text('Price: ₦${book['price']}'),
//                           );
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Text(
//                         'Total Amount: ₦${cartProvider.calculateTotal().toStringAsFixed(2)}',
//                         style: Theme.of(context).textTheme.headlineMedium
//                     ),
//                     const SizedBox(height: 20),
//                     MyElevatedButton(
//                       buttonText: 'Make Payment',
//                       onPressed: () {
//                         _handlePayment(
//                           cartProvider.calculateTotal(),
//                           user,
//                           cartBooks,
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }



//await cartProvider.clearCart();


// import 'package:price_app/features/utils/exports.dart';
// import 'package:uuid/uuid.dart';
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:uuid/uuid.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:url_launcher/url_launcher.dart';
//
// // Import your custom providers and models
//
// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({Key? key}) : super(key: key);
//
//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }
//
// class _PaymentScreenState extends State<PaymentScreen> {
//   final String publicKey = "FLWPUBK_faaac6e3fecc65bb9f192f3a9ca93659-X";
//   final String secretKey = "FLWSECK_24dbac6146b9ddff4635e9a5ac58e19b-191d85a9318vt-X";
//   final _secureStorage = const FlutterSecureStorage();
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _loadUserAndCart();
//     });
//   }
//
//   Future<void> _loadUserAndCart() async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     final cartProvider = Provider.of<CartProvider>(context, listen: false);
//
//     String? userId = await _secureStorage.read(key: 'userId');
//     await userProvider.fetchUserProfile(userId!);
//     await cartProvider.fetchCartData();
//   }
//
//   Future<void> _handlePayment(BuildContext context, double amount, User user, List<dynamic> cartBooks) async {
//     final String txRef = const Uuid().v4();
//     final url = Uri.parse('https://api.flutterwave.com/v3/payments');
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $secretKey'
//     };
//
//     final body = jsonEncode({
//       'tx_ref': txRef,
//       'amount': amount,
//       'currency': 'NGN',
//       'redirect_url': 'https://your-redirect-url.com',
//       'customer': {
//         'email': user.email,
//         'name': '${user.firstName} ${user.lastName}',
//         'phonenumber': user.phoneNumber
//       },
//       'customizations': {
//         'title': 'Book Payment',
//         'logo': 'https://your-logo-url.com/logo.png'
//       }
//     });
//
//     try {
//       final response = await http.post(url, headers: headers, body: body);
//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         final paymentLink = responseData['data']['link'];
//         if (await canLaunch(paymentLink)) {
//           await launch(paymentLink);
//           // Start polling for payment status
//           _pollPaymentStatus(txRef);
//         } else {
//           throw 'Could not launch $paymentLink';
//         }
//       } else {
//         throw 'Failed to generate payment link: ${response.body}';
//       }
//     } catch (e) {
//       _showMessage("An error occurred: $e", isError: true);
//     }
//   }
//
//   Future<void> _pollPaymentStatus(String txRef) async {
//     bool paymentCompleted = false;
//     int attempts = 0;
//     const maxAttempts = 10;  // Adjust as needed
//
//     while (!paymentCompleted && attempts < maxAttempts) {
//       await Future.delayed(Duration(seconds: 5));  // Wait for 5 seconds between each check
//
//       try {
//         final status = await _checkPaymentStatus(txRef);
//         if (status == 'successful') {
//           paymentCompleted = true;
//           _onPaymentSuccess();
//         } else if (status == 'failed') {
//           _showMessage("Payment failed", isError: true);
//           return;
//         }
//       } catch (e) {
//         print("Error checking payment status: $e");
//       }
//
//       attempts++;
//     }
//
//     if (!paymentCompleted) {
//       _showMessage("Payment status unclear. Please check your account.", isError: true);
//     }
//   }
//
//   Future<String> _checkPaymentStatus(String txRef) async {
//     final url = Uri.parse('https://api.flutterwave.com/v3/transactions/verify_by_reference?tx_ref=$txRef');
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $secretKey'
//     };
//
//     final response = await http.get(url, headers: headers);
//     if (response.statusCode == 200) {
//       final responseData = jsonDecode(response.body);
//       return responseData['data']['status'];
//     } else {
//       throw Exception('Failed to check payment status');
//     }
//   }
//
//   void _onPaymentSuccess() {
//     // Handle successful payment
//     _showMessage("Payment Successful!");
//     // Clear cart, add books to library, etc.
//     _addBooksToLibraryInBackground();
//   }
//
//   void _addBooksToLibraryInBackground() {
//     // Use a microtask to run this code after the current build cycle
//     Future.microtask(() async {
//       final cartProvider = Provider.of<CartProvider>(context, listen: false);
//       final bookProvider = Provider.of<BookProvider>(context, listen: false);
//       final cartBooks = cartProvider.cartBooks;
//
//       for (var cartItem in cartBooks) {
//         try {
//           await bookProvider.addBookToLibrary(cartItem['bookId']['_id']);
//         } catch (e) {
//           print("Failed to add book ${cartItem['bookId']['title']} to library: $e");
//           // Consider implementing a retry mechanism or notifying the user if this fails
//         }
//       }
//
//       // Clear the cart after adding books to the library

//
//       // Navigate to LibraryPage
//       Navigator.pushNamed(context, '/library');
//     });
//   }
//
//   void _showMessage(String message, {bool isError = false}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError ? Colors.red : Colors.green,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<UserProvider>(
//       builder: (context, userProvider, _) {
//         return Consumer<CartProvider>(
//           builder: (context, cartProvider, _) {
//             final user = userProvider.user;
//             final cartBooks = cartProvider.cartBooks;
//
//             if (user == null || cartBooks.isEmpty) {
//               return Scaffold(
//                 appBar: AppBar(title: const Text("Payment")),
//                 body: const Center(child: CircularProgressIndicator(
//                   color: Color(0xFF0B6F17),
//                 )),
//               );
//             }
//
//             return Scaffold(
//               appBar: AppBar(
//                   backgroundColor: const Color(0xFF0B6F17),
//                   elevation: 200,
//                   leading: IconButton(
//                     icon: const Icon(Icons.arrow_back, color: Colors.white,),
//                     onPressed: () => Navigator.of(context).pushReplacementNamed('/cart_zero'),
//                   ),
//                   title: const Text(
//                     "Payment",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   )
//               ),
//               body: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Payment Details:', style: Theme.of(context).textTheme.headlineMedium),
//                     const SizedBox(height: 10),
//                     Text('Name: ${user.firstName} ${user.lastName}'),
//                     Text('Email: ${user.email}'),
//                     Text('Phone: ${user.phoneNumber}'),
//                     const SizedBox(height: 20),
//                     Text('Cart Items:', style: Theme.of(context).textTheme.titleMedium),
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: cartBooks.length,
//                         itemBuilder: (context, index) {
//                           final book = cartBooks[index]['bookId'];
//                           return ListTile(
//                             title: Text(book['title']),
//                             subtitle: Text('Price: ₦${book['price']}'),
//                           );
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Text(
//                         'Total Amount: ₦${cartProvider.calculateTotal().toStringAsFixed(2)}',
//                         style: Theme.of(context).textTheme.headlineMedium
//                     ),
//                     const SizedBox(height: 20),
//                     MyElevatedButton(
//                       buttonText: 'Make Payment',
//                       onPressed: () {
//                         _handlePayment(
//                           context,
//                           cartProvider.calculateTotal(),
//                           user,
//                           cartBooks,
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }










// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({super.key});
//
//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }
//
//
//
// class _PaymentScreenState extends State<PaymentScreen> {
//   final String publicKey = "FLWPUBK_faaac6e3fecc65bb9f192f3a9ca93659-X";
//   final String encryptionKey = "FLWSECK_24dbac6146b9854e71d473fb";
//   final _secureStorage = const FlutterSecureStorage();
//   int _currentIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _loadUserAndCart();
//     });
//   }
//
//   Future<void> _loadUserAndCart() async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     final cartProvider = Provider.of<CartProvider>(context, listen: false);
//
//     String? userId = await _secureStorage.read(key: 'userId');
//     await userProvider.fetchUserProfile(userId!);
//     await cartProvider.fetchCartData();
//   }
//
//   void _onItemTapped(int index) {
//     setState(() => _currentIndex = index);
//   }
//
//   void _handlePayment(BuildContext context, double amount, User user,
//       List<dynamic> cartBooks) async {
//     final customer = Customer(
//       name: "${user.firstName} ${user.lastName}",
//       phoneNumber: user.phoneNumber,
//       email: user.email,
//     );
//
//     final Flutterwave flutterwave = Flutterwave(
//         context: context,
//         publicKey: publicKey,
//         currency: "NGN",
//         txRef: const Uuid().v4(),
//         amount: amount.toString(),
//         customer: customer,
//         paymentOptions: "card, ussd",
//         customization: Customization(title: "Book Payment"),
//         isTestMode: false,
//
//         redirectUrl: 'https://your-redirect-url.com');
//
//     try {
//       final ChargeResponse response = await flutterwave.charge();
//       if (response.success == true) {
//         // Show loading indicator
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (BuildContext context) {
//             return const Center(child: CircularProgressIndicator());
//           },
//         );
//
//         // Clear the cart
//         final cartProvider = Provider.of<CartProvider>(context, listen: false);
//         await cartProvider.clearCart();
//
//         // Navigate to LibraryPage
//         Navigator.pushNamed(context, '/library');
//
//         // Add books to library in the background
//         _addBooksToLibraryInBackground(cartBooks);
//
//         // Show success message
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//               content: Text(
//                   "Payment Successful. Your books are being added to your library.")),
//         );
//       } else {
//         _showMessage("Payment Failed: ${response.status}", isError: true);
//       }
//     } catch (error) {
//       _showMessage("An error occurred: ${error.toString()}", isError: true);
//     }
//   }
//
//   void _addBooksToLibraryInBackground(List<dynamic> cartBooks) {
//     // Use a microtask to run this code after the current build cycle
//     Future.microtask(() async {
//       final bookProvider = Provider.of<BookProvider>(context, listen: false);
//       for (var cartItem in cartBooks) {
//         try {
//           await bookProvider.addBookToLibrary(cartItem['bookId']['_id']);
//         } catch (e) {
//           print(
//               "Failed to add book ${cartItem['bookId']['title']} to library: $e");
//           // Consider implementing a retry mechanism or notifying the user if this fails
//         }
//       }
//     });
//   }
//
//   void _showMessage(String message, {bool isError = false}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError ? Colors.red : Colors.green,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<UserProvider>(
//       builder: (context, userProvider, _) {
//         return Consumer<CartProvider>(
//           builder: (context, cartProvider, _) {
//             final user = userProvider.user;
//             final cartBooks = cartProvider.cartBooks;
//
//             if (user == null || cartBooks.isEmpty) {
//               return Scaffold(
//                 appBar: AppBar(title: const Text("Payment")),
//                 body: const Center(child: CircularProgressIndicator(
//                   color: Color(0xFF0B6F17),
//                 )),
//               );
//             }
//
//             return Scaffold(
//               appBar: AppBar(
//                   backgroundColor: const Color(0xFF0B6F17),
//                   elevation: 200,
//                   leading: IconButton(
//                     icon: const Icon(
//                       Icons.arrow_back,
//                       color: Colors.white,),
//                     onPressed: () => Navigator.of(context).pushReplacementNamed('/cart_zero'), // Replace with your home route
//                   ),
//                   title: const Text(
//                     "Payment",
//                     style:TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   )
//               ),
//               body: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Payment Details:',
//                         style: Theme.of(context).textTheme.headlineMedium),
//                     const SizedBox(height: 10),
//                     Text('Name: ${user.firstName} ${user.lastName}'),
//                     Text('Email: ${user.email}'),
//                     Text('Phone: ${user.phoneNumber}'),
//                     const SizedBox(height: 20),
//                     Text('Cart Items:',
//                         style: Theme.of(context).textTheme.titleMedium),
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: cartBooks.length,
//                         itemBuilder: (context, index) {
//                           final book = cartBooks[index]['bookId'];
//                           return ListTile(
//                             title: Text(book['title']),
//                             subtitle: Text('Price: ₦${book['price']}'),
//                           );
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Text(
//                         'Total Amount: ₦${cartProvider.calculateTotal().toStringAsFixed(2)}',
//                         style: Theme.of(context).textTheme.headlineMedium),
//                     const SizedBox(height: 20),
//                     MyElevatedButton(
//                       buttonText: 'Make Payment',
//                       onPressed: () {
//                         _handlePayment(
//                           context,
//                           cartProvider.calculateTotal(),
//                           user,
//                           cartBooks,
//                         );
//                       },
//                     ),
//
//                   ],
//                 ),
//               ),
//
//             );
//           },
//         );
//       },
//     );
//   }
// }

