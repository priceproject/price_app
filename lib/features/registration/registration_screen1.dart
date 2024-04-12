import 'package:price_app/features/utils/exports.dart';


class Registration1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
        appBar:CustomAppBar,
=======
        appBar:RegAndAuthAppBar,
>>>>>>> 2bc3c23b0d99f58320777db4461f6b2c925bf66b
        body: Padding(
          padding:  EdgeInsets.all(20.0.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               Text('Hello! Register to get Started',
                  style: KHeadingTextStyle),
               SizedBox(height: 15.h,),
              CustomTextField(placeholder: 'Firstname*'),
               SizedBox(height: 10.sp),
              CustomTextField(placeholder: 'Lastname*'),
               SizedBox(height: 10.sp),
              CustomTextField(placeholder: 'Email*'),
               SizedBox(height: 10.h),
              CustomTextField(placeholder: 'Phone number*'),
               SizedBox(height: 80.h),
              MyTextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/registration2');
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
              )
            ],
          ),
        ));
  }
}
