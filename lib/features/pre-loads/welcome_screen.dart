import "package:price_app/features/utils/exports.dart";

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
            body: Container(
            alignment: Alignment.topLeft,
            width: double.infinity,
            decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage('images/welcome Screen.png'),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter
              )
              ),
              child:Padding(
                padding: const EdgeInsets.only(top: 80.0, right: 30, left: 30, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.5,
                    ),
                    Image(
                      image: AssetImage('images/logo-text.png'),
                      height: 100,
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    MyTextButton(buttonText: 'Login', onPressed: () { Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    ); },),
                    SizedBox(
                      height: 20,
                    ),
                    MyTextButton(buttonText: 'Register', onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute
                          (builder: (context) => Registration1()),
                      );
                    },),
                  ],),
              ),
          )
            ),
    ); 
  }
}

