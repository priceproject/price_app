import 'package:price_app/features/utils/exports.dart';


class LibraryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String customTitle;
  String ?bookQty;
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  LibraryAppBar({ required this.customTitle, this.bookQty,});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 20.0),
          child: Image.asset('images/back.png'),
        ),),
      title: Text(customTitle),
      centerTitle: true,
      actions: [Text('(60)')],
    );
  }
}

