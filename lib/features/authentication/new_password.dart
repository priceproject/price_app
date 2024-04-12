import "package:price_app/features/utils/exports.dart";

class NewPassword extends StatelessWidget {

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
               Text('Create new Password',
                style: KHeadingTextStyle
              ),
              Text('Your new password must be unique from those previously used.',
              style: KSubHeadingTextStyle,
              ),
              const SizedBox(height: 15),
              CustomTextField(placeholder: 'New Password'),
              const SizedBox(height: 10),
              CustomTextField(
                  placeholder: 'Confirm Password',),
              const SizedBox(height: 80),
              MyTextButton(buttonText: 'Reset Password', onPressed: () {},),
            ],
          ),
        )
    );
  }
}