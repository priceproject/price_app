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