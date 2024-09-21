import "dart:convert";
import 'package:http/http.dart'as http;

import "package:price_app/features/utils/exports.dart";

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> sendOTP(String email) async {
    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('https://seedapp.vercel.app/api/forgetPassword'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Verification(email: email)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send OTP: ${jsonDecode(response.body)['error']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF0B6F17),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      'Forget Password?',
                      style: KHeadingTextStyle.copyWith(fontSize: 24.sp),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Don't worry it occurs. "
                          "Please enter the email address used with your account",
                      style: KSubHeadingTextStyle.copyWith(fontSize: 16.sp),
                    ),
                    SizedBox(height: 15.h),
                    TextFormField(
                      autofocus: false,
                      controller: _emailController,
                      validator: validateEmail,
                      decoration: buildInputDecoration("Enter Email", Icons.email),
                    ),
                    SizedBox(height: 80.h),
                    MyElevatedButton(
                      onPressed: () {
                        sendOTP(_emailController.text.trim());
                      },
                      buttonText: 'Send Code',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: BottomActionText(
              question: 'Remember Password?',
              action: 'Login',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
