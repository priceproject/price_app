import 'package:price_app/features/utils/exports.dart';

class LibraryList extends StatelessWidget {
  const LibraryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDFDFDF),
      appBar: LibraryAppBar(customTitle: 'My Library',bookQty: '(60)',),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.07,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height*0.93,
            child: ListView(children: [
              LibraryListRow(),
            ],),
          ),
        ],
      ),
    );
  }
}
