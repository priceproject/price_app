import 'package:price_app/features/utils/exports.dart';

class Registration3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
        appBar: CustomAppBar,
=======
        appBar: RegAndAuthAppBar,
>>>>>>> 2bc3c23b0d99f58320777db4461f6b2c925bf66b
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "You're amazing! Now your password",
                style: KHeadingTextStyle
              ),
              SizedBox(height: 15),
              CustomTextField(
                placeholder: 'Password*',
                obscureText: true,
              ),
              SizedBox(height: 10),
              CustomTextField(
                placeholder: 'Confirm Password',
                obscureText: true,
              ),
              const SizedBox(height: 80),
              MyTextButton(
                buttonText: 'Register',
                onPressed: () {},
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
        ));
  }
}
