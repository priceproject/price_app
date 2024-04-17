import "package:price_app/features/utils/exports.dart";



List<Map<String, dynamic>> allBookData = [];

void combineBookLists() {
  allBookData.addAll(outreachBookData);
  allBookData.addAll(studyBookData);
  allBookData.addAll(marriageBookData);
}