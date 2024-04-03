import 'package:price_app/features/utils/exports.dart';

class horizontal_scroll_view extends StatelessWidget {
  const horizontal_scroll_view({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Books(imageProvider: AssetImage('images/bone of your bones.jpg')),
          SizedBox(width: 30,),
          Books(imageProvider: AssetImage('images/bone of your bones.jpg')),
          SizedBox(width: 30,),
          Books(imageProvider: AssetImage('images/bone of your bones.jpg')),
          SizedBox(width: 30,),
          Books(imageProvider: AssetImage('images/bone of your bones.jpg')),
          SizedBox(width: 30,),
          IconButton(
            icon: Icon(
                Icons.arrow_forward,
                size: 100,
                weight: 150,
                color: Colors.grey), // Adjust size and color as needed
            onPressed: () {
              // Navigate to another page
            },
          ),

        ],

      ),
    );
  }
}

class Books extends StatelessWidget {
  Books({
    required this.imageProvider});

  final ImageProvider imageProvider;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 150,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image(
            image: imageProvider,
            fit: BoxFit.cover,
          )
      ),
    );
  }
}