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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image(image: AssetImage('images/ProfilePage Images/profile banner.png'),
            fit: BoxFit.cover,),
          Padding(
            padding: const EdgeInsets.only(right: 45.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 40,
                  child: Icon(Icons.hub,size: 60,),
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Bro. Samuel Kwaku Amoah'),
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
          Column(

          )
        ],
      ),
    );
  }
}
