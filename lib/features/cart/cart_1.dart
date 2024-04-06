import 'package:flutter/cupertino.dart';
import 'package:price_app/features/utils/exports.dart';

class CartOne extends StatelessWidget {
  const CartOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDFDFDF),
      appBar: CartAppBar(customTitle: 'Cart(3)',),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        margin: EdgeInsets.only(top: 8, bottom: 1),
        color: Colors.white,
        child: Column(
          children: [
            Row(children: [
              CustomCheckboxWidget(),
              SizedBox(width: 20,),
              Text('Select All', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,),)

            ],),
            SizedBox(height: 20,),
            Row(children: [
              CustomCheckboxWidget(),
              Image(image: AssetImage('images/bone of your bones.jpg')),
              Spacer(),
              Column(children: [
                Text('The journey into your Vision'),
                SizedBox(height: 10,),
                Row(children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.remove_circle_outline)),
                  SizedBox(width: 10,),
                  Text('1'),
                  SizedBox(width: 10,),
                  IconButton(onPressed: (){}, icon: Icon(Icons.add_circle_rounded)),
                ],)
              ],),
              Spacer(),
              Column(children: [
                Text('N250'),
                SizedBox(height: 10,),
                IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.delete))
              ],)
            ],),
            Spacer(),
            CustomCartButtonTwoA(child: 'Checkout (2)', onPressed: (){})
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 1, onTap: (int ) {  },),
    );
  }
}
