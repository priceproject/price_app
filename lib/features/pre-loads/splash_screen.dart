import "package:price_app/features/utils/exports.dart";

class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  initState() {
    super.initState();
    _navigateToInitialRoute();
  }

  _navigateToInitialRoute() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushNamed(context, '/payment_screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.bottomCenter,
        height: MediaQuery.of(context).size.height*0.95,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'images/livingSeed logo.jpg'),
          ),
        ),
        child: Image.asset('images/livingSeed text.jpg'),
      ),
    );
  }
}
