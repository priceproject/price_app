import 'package:price_app/features/utils/exports.dart';

class Registration3 extends StatefulWidget {

  @override
  State<Registration3> createState() => _Registration3State();
}

class _Registration3State extends State<Registration3> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar,
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Builder(
              builder: (context)=>Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                    "You're amazing! Now your password",
                    style: KHeadingTextStyle
                ),
                SizedBox(height: 15),
                CustomTextField(
                  controller: _passwordController,
                  placeholder: 'Password*',
                  obscureText: true,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: _confirmPasswordController,
                  placeholder: 'Confirm Password',
                  obscureText: true,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please confirm your password';
                    } else if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 80),
                MyTextButton(
                  buttonText: 'Register',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePageScreen()),
                      );
                    }
                  },
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
                ),
              ],
            ),
            ),
          ),
        ));
  }
  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

}


