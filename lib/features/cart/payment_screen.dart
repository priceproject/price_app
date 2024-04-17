import 'package:price_app/features/utils/exports.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDFDFDF),
      appBar: CartAppBar(customTitle: "Confirm your order"),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        padding: EdgeInsets.all(30),
        margin: EdgeInsets.only(top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text('How would you like to pay?',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 8,),
          Text(' Choose the most suitable payment method \n for you.',
              style: TextStyle(
                fontSize: 15,
              )),
          SizedBox(height: 20,),
            PaymentRadioButton(),
            Spacer(),
            Container(
              alignment: Alignment.center,
              child: Text('By continuing, you agree to our privacy policy and terms of use.',
                style: TextStyle(
                fontSize: 10,
                fontStyle: FontStyle.italic
              ),),
            ),
            SizedBox(height: 20,),
            CustomCartButtonTwoA(child: 'Make Payment (N500)', onPressed: (){})
        ],),
      ),
    );
  }
}
