import "package:price_app/features/utils/exports.dart";

class ForgetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: AppBarLeadingArrow(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               Text(
                'Forget Password?',
                style: KHeadingTextStyle,
              ),
               Text(
                "Don't worry it occurs. "
                "Please enter the email address used with your account",
                style: KSubHeadingTextStyle,
              ),
               SizedBox(height: 15),
              CustomTextField(placeholder: 'Enter your email'),
               SizedBox(height: 80),
              MyTextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Verification()),
                  );
                },
                buttonText: 'Send Code',
              ),
              Spacer(),
              BottomActionText(
                question: 'Remember Password?',
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
