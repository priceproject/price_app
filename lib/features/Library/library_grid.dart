import 'package:price_app/features/utils/exports.dart';

class LibraryGrid extends StatelessWidget {
  const LibraryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFDFDF),
      appBar: LibraryAppBar(customTitle: 'My Library', bookQty: '(60)'),
      body: Container(

      ),
    );
  }
}
