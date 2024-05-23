import 'package:price_app/features/utils/exports.dart';

class Registration2 extends StatefulWidget {


  @override
  State<Registration2> createState() => _Registration2State();
}

class _Registration2State extends State<Registration2> {
  final _genderController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar,
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child:Builder(
              builder: (context)=>Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Awesome! You're almost done",
                  style: KHeadingTextStyle,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  controller: _genderController,
                  placeholder: 'Gender*',
                  validator: (value){
                    if (value?.isEmpty ?? true){
                      return "Please Select your gender";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: _dateOfBirthController,
                  placeholder: 'Date of Birth*',
                  validator: (value){
                    if (value?.isEmpty ?? true){
                      return "Please fill this field";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: _countryController,
                  placeholder: 'Country of Residence*',
                  validator: (value){
                    if (value?.isEmpty ?? true){
                      return "Please fill this field";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: _stateController,
                  placeholder: 'State of Residence*',
                  validator: (value){
                    if (value?.isEmpty ?? true){
                      return "Please fill this field";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 80),
                MyTextButton(
                  onPressed: () {
                    if (_formKey.currentState != null) {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushNamed(context, '/registration3');
                      }
                    } else {
                      print('_formKey.currentState is null');
                    }
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
            )

          ),
        ));
  }

  @override
  void dispose() {
    _genderController.dispose();
    _dateOfBirthController.dispose();
    _countryController.dispose();
    _stateController.dispose();
    super.dispose();
  }
}