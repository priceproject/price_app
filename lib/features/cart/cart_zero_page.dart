import 'package:price_app/features/utils/exports.dart';

class CartZero extends StatelessWidget {
  const CartZero({super.key});

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    return Expanded(
      child: Scaffold(
        backgroundColor: Color(0xFFDFDFDF),
        appBar: AppBar(
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 20.0),
              child: Image.asset('images/back.png'),
            ),),
          title: Text('Carts(0)'),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 4, bottom: 2),
          color: Colors.white,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  width: sw*0.6,
                  height: sh*0.5,
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Image.asset('images/Cart Images/zero cart.png',),
                      Spacer(),
                      Text('Nothing in your Cart?',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),),
                      Spacer(),
                      Text('That\'s ok, take your time to browse\n through our resources until you find\n what you\'re looking for.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                      CustommCartButton(buttonText: 'Continue Browsing', onPressed: (){})
                    ],
                  ),
                ),
                Spacer(),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: const BookScrollTitle(mainTitle: 'Books you might like', subAction: 'See more...',),
                ),
                Container(
                  child: horizontal_scroll_view(),
                )
              ],
            ),
          )
        ),
        bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0, onTap: (int ) {  },)
      ),
    );
  }
}

