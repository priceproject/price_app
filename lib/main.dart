import 'package:price_app/features/utils/exports.dart';


void main()=> runApp(PriceApp());
class PriceApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_ , child) {
        return MaterialApp(
          initialRoute: '/',
          routes: appRoutes,
          debugShowCheckedModeBanner: false,
        );
      }
    );
  }
}


