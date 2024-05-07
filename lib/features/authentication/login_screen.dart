import "package:price_app/features/utils/exports.dart";


class Login extends StatefulWidget {

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar,
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Welcome back. Glad to see you Again!',
                  style: KHeadingTextStyle,
                ),
                SizedBox(height: 15.h),
                CustomTextField(placeholder: 'PH-Code/Email'),
                SizedBox(height: 10.h),
                CustomTextField(
                    placeholder: 'Enter your Password',
                    obscureText: true),
                ForgotPassword(),
                const SizedBox(height: 80),
                MyTextButton(buttonText: 'Login', onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePageScreen()
                    ),
                  );
                },
                ),
                Spacer(),
                BottomActionText(
                  question: 'Already have PH-Code?', action: 'Register Here', onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute
                      (builder: (context) => Registration1()),
                  );
                },

                )
              ]
          ),

      ),

    );


  }


}


