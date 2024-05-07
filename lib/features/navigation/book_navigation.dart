import "package:price_app/features/utils/exports.dart";


void navigateToBookScreen(BuildContext context, String category) {
  switch (category) {
    case "Study":
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const StudyBookScreen()),
      );
      break;
    case "Marriage":
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MarriageBookScreen()),
      );
      break;
    case "Outreach":
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OutreachBookScreen()),
      );
      break;
    case "All":
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>AllBookScreen()),
      );
      break;
  }
}

void navigateToScreen(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePageScreen()),
      );
      break;
    case 1:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PaymentScreen()),
      );
      break;
    case 2:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CartZero()),
      );
      break;
    case 3:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Profile()),
      );
      break;
  }
}