import "package:price_app/features/utils/exports.dart";


class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RegAndAuthAppBar,
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
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>HomePageScreen(),
                    ),
                );
              },
              ),
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

