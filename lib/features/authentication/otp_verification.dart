import "package:price_app/features/utils/exports.dart";

class Verification extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               Text('OTP Verification',
                style: KHeadingTextStyle,
              ),
              Text('Enter the verification code we just sent on you email address',
              style:KSubHeadingTextStyle,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OTPBox(),
                  OTPBox(),
                  OTPBox(),
                  OTPBox(),
                ],
              ),

              const SizedBox(height: 80),
              MyTextButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute
                    (builder: (context) => NewPassword()),
                );
              },
                buttonText: 'Verify',),
              Spacer(),
              BottomActionText(question: "Did not received code?", action: 'Resend', onTap: (){},),
            ],
          ),
        )
    );
  }
}


