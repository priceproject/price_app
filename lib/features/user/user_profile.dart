import 'package:price_app/features/utils/exports.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search_rounded),)
        ],
      ),
       body: Container(
         alignment: Alignment.topLeft,
         width: double.infinity,
         decoration: BoxDecoration(
           image: DecorationImage(
             image: AssetImage('images/ProfilePage Images/profile banner.png'),
             fit: BoxFit.fitWidth,
             alignment: Alignment.topCenter
           )
         ),
         child: Column(
           children: [
             Padding(
               padding: const EdgeInsets.only(right: 50.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   CircleAvatar(
                     backgroundColor: Colors.white60,
                     radius: 40,
                     child: Icon(Icons.hub,size: 60,),
                   ),
                   Column(
                     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       SizedBox(height: 100,),
                       Text('Bro. Samuel Kwaku Amoah',
                         style: TextStyle(
                             fontWeight: FontWeight.w900,
                            fontSize: 15,
                           color: Colors.black87
                         ),),
                       Row(
                         children: [
                           Container(
                             padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                             margin: EdgeInsets.all(10),
                             decoration: KProfileContainerDecor,
                             child: Row(
                               children: [
                                 Image(image: AssetImage('images/ProfilePage Images/country icon.png'),),
                                 SizedBox(width: 10,),
                                 Text('Ghana')
                               ],
                             ),
                           ),
                           Container(
                             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                             margin: EdgeInsets.all(10),
                             decoration: KProfileContainerDecor,
                             child: Text('Joined 2023'),
                           )
                         ],
                       )
                     ],
                   )
                 ],
               ),
             ),
             Padding(
               padding: const EdgeInsets.all(20.0),
               child: Column(
                 children: [
                   SizedBox(height: 30,),
                   Container(
                     decoration: BoxDecoration(
                       border: Border(
                         bottom: BorderSide(
                           color: Colors.grey, // Border color
                           width: 1, // Border width
                         ),
                       ),
                     ),
                     child: Row(
                       children: [
                         Image(image: AssetImage('images/ProfilePage Images/ph-code icon.png'),
                         ),
                         SizedBox(width: 15,),
                         Text('BYE23-M385911')
                       ],
                     ),
                   )
                 ],
               ),
             )
           ],
         ),
       )
    );
  }
}
