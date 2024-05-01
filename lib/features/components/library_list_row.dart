import 'package:price_app/features/utils/exports.dart';


class LibraryListRow extends StatelessWidget {
  const LibraryListRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF0D5415), // Color of the border
            width: 1.5, // Thickness of the border
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('images/bone of your bones.jpg'),
          SizedBox(width: 30,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Finding the bone of my bones'),
              SizedBox(height: 10,),
              Text('By Gbile Akanni')
            ],)
        ],),
    );
  }
}
