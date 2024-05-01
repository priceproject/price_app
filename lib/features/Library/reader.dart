import 'package:price_app/features/utils/exports.dart';

class Reader extends StatelessWidget {
  const Reader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDFDFDF),
      appBar: LibraryAppBar(customTitle: 'From bleak to bliss',),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.08,
            child: Container(alignment: Alignment.center,
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(3),
              child: Text('Chapter 1',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13
                ),),
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            height: MediaQuery.of(context).size.height*0.92,
            // child:,
          ),
        ],
      ),
    );
  }
}
