import 'package:price_app/features/utils/exports.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const Splash(), // Default route
  '/welcome': (context) => const WelcomeScreen(),
  '/registration1': (context) => const Registration1(),
  '/registration2': (context) => const Registration2(),
  '/home': (context) => const MainNavigationScreen(initialIndex: 0),
  '/community': (context) => const MainNavigationScreen(initialIndex: 1),
  '/library': (context) => const MainNavigationScreen(initialIndex: 2),
  '/customer_support': (context) => const MainNavigationScreen(initialIndex: 3), // Updated index
  '/profile': (context) => const MainNavigationScreen(initialIndex: 4), // Updated index
  '/login': (context) => const Login(),
  '/user_profile': (context) => const MainNavigationScreen(initialIndex: 4), // Updated index
  '/cart_zero': (context) => MainNavigationScreen(initialIndex: 0, initialPage: CartPage()),
  '/payment_screen': (context) => MainNavigationScreen(initialIndex: 0, initialPage: PaymentScreen()),
  '/book_details': (context) => MainNavigationScreen(initialIndex: 0, initialPage: BookDetailsScreen(bookId: ModalRoute.of(context)!.settings.arguments as String),),
  '/book_display': (context) => MainNavigationScreen(initialIndex: 0, initialPage: BooksDisplay()),
  '/reader': (context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return MainNavigationScreen(
      initialIndex: 2,
      initialPage: PDFViewerPage(
        bookTitle: args['bookTitle'],
        pdfUrl: args['pdfUrl'],
      ),
    );
  },
};