import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class BooksImage extends StatelessWidget {
  BooksImage({
    required this.imageProvider});

  final ImageProvider imageProvider;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      height: 290,
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