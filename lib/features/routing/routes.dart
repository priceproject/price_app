import 'package:price_app/features/utils/exports.dart';


Map<String,  WidgetBuilder> appRoutes={
'/': (context) => Splash(), // Default route
'/welcome': (context) => WelcomeScreen(),
'/registration1': (context) => Registration1(),
'/registration2': (context) => Registration2(), // Route for Registration2
'/registration3': (context) => Registration3(), // Route for Registration3
'/login': (context) => Login(),
'/user_profile': (context) => Profile(),
  '/cart_zero': (context) => CartZero(),
  '/pay_successful': (context) => PaySuccessful(),
};