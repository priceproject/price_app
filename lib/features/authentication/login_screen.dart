import "package:price_app/features/utils/exports.dart";


class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
        appBar: CustomAppBar,
=======
        appBar: RegAndAuthAppBar,
>>>>>>> 2bc3c23b0d99f58320777db4461f6b2c925bf66b
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               Text('Welcome back. Glad to see you Again!',
                style: KHeadingTextStyle,
              ),
              const SizedBox(height: 15),
              CustomTextField(placeholder: 'PH-Code/Email'),
              const SizedBox(height: 10),
              CustomTextField(
                  placeholder: 'Enter your Password',
                  obscureText: true),
              ForgotPassword(),
              const SizedBox(height: 80),
              MyTextButton(buttonText: 'Login', onPressed: () {
<<<<<<< HEAD
                Navigator.pushNamed(context, '/login');
=======
                Navigator.pushNamed(context, '/user_profile');
>>>>>>> 2bc3c23b0d99f58320777db4461f6b2c925bf66b
              },),
              Spacer(),
              BottomActionText(question: 'Already have PH-Code?', action: 'Register Here', onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute
                    (builder: (context) => Registration1()),
                );
              },),
            ],
          ),
        )
    );
  }
}

