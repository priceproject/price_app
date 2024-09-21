import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:price_app/features/utils/exports.dart";

class NewPassword extends StatefulWidget {
  final String email;
  const NewPassword({super.key, required this.email});

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  Future<void> resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('https://seedapp.vercel.app/api/resetPassword'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': widget.email,
          'newPassword': _newPasswordController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Password reset successful
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      } else {
        // Error resetting password
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to reset password: ${jsonDecode(response.body)['error']}')),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: ScreenUtil().screenHeight - AppBar().preferredSize.height - MediaQuery.of(context).padding.top,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Create new Password', style: KHeadingTextStyle.copyWith(fontSize: 24.sp)),
                  SizedBox(height: 10.h),
                  Text(
                    'Your new password must be unique from those previously used.',
                    style: KSubHeadingTextStyle.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 15.h),
                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: buildInputDecoration("New Password", Icons.lock),
                    style: TextStyle(fontSize: 16.sp),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a new password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: buildInputDecoration("Confirm Password", Icons.lock),
                    style: TextStyle(fontSize: 16.sp),
                    validator: (value) {
                      if (value != _newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 80.h),
                  _isLoading
                      ? Center(child: CircularProgressIndicator(strokeWidth: 3.w, color: Color(0xFF0B6F17),))
                      : MyElevatedButton(
                    buttonText: 'Reset Password',
                    onPressed: resetPassword,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}