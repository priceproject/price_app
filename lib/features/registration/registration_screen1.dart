import 'package:price_app/features/utils/exports.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Registration1 extends StatefulWidget {
  @override
  State<Registration1> createState() => _Registration1State();
}

class _Registration1State extends State<Registration1> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:RegAndAuthAppBar,
        body: Padding(
          padding:  EdgeInsets.all(20.0.sp),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Hello! Register to get Started',
                    style: KHeadingTextStyle),
                SizedBox(height: 15.h,),
                CustomTextField(
                    controller: _firstNameController,
                    placeholder: 'Firstname*',
                validator: (value){
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
                ),
                SizedBox(height: 10.sp),
                CustomTextField(
                    controller: _lastNameController,
                    placeholder: 'Lastname*',
                validator: (value){
                      if (value?.isEmpty ?? true){
                        return "Please enter your last name";
                      }
                      return null;
                },
                ),
                SizedBox(height: 10.sp),
                CustomTextField(
                    controller: _emailController,
                    placeholder: 'Email*',
                  validator: (value){
                    if (value?.isEmpty ?? true){
                      return "Please enter valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                    controller: _passwordController,
                    placeholder: 'password*',
                  validator: (value){
                    if (value?.isEmpty ?? true){
                      return "Please enter your password";
                    }
                    return null;
                  },),
                SizedBox(height: 80.h),
                MyTextButton(
                  onPressed: () async{
                    if (_formKey.currentState!.validate()) {
                      // Data is valid, you can proceed with registration
                      final authService = AuthService();
                      final registrationSuccessful = await authService.registerUser(
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                      );

                      if (registrationSuccessful){
                        Navigator.pushNamed(context, '/registration2');
                      } else {
                        // Registration failed, show an error message
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Registration Failed'),
                            content: Text(
                                'An error occurred during registration. Please try again.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                  buttonText: 'Continue',
                ),
                Spacer(),

                BottomActionText(
                  question: 'Already have an account?',
                  action: 'Login',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                )
              ],
            ),

          ),
        ));
  }
  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}



class AuthService {
  static const String baseUrl = 'http://localhost:3000/api/register';

  Future<bool> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      }),
    );


    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Status code in the 200 range indicates success
      // You can still parse the response body for additional data if needed
      return true;
    } else {
      throw Exception('Registration failed: ${response.body}');
    }
  }
}