import 'package:price_app/features/utils/exports.dart';

class Registration2 extends StatelessWidget {
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
                "Awesome! You're almost done",
                style: KHeadingTextStyle,
              ),
              SizedBox(height: 15),
              CustomTextField(placeholder: 'Gender*'),
              SizedBox(height: 10),
              CustomTextField(placeholder: 'Date of Birth*'),
              SizedBox(height: 10),
              CustomTextField(placeholder: 'Country of Residence*'),
              SizedBox(height: 10),
              CustomTextField(placeholder: 'State of Residence*'),
              const SizedBox(height: 80),
              MyTextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/registration3');
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
              ),
            ],
          ),
        ));
  }
}
