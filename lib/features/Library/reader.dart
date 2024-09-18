import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:price_app/features/utils/exports.dart';

class PdfViewerProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

class PDFViewerPage extends StatefulWidget {
  final String pdfUrl;
  final String bookTitle;

  const PDFViewerPage({Key? key, required this.pdfUrl, required this.bookTitle}) : super(key: key);

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> with WidgetsBindingObserver {
  late PdfViewerController _pdfViewerController;
  int _currentIndex = 0;
  String? _localPdfPath;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    WidgetsBinding.instance.addObserver(this);
    if (!kIsWeb) {
      _downloadAndCachePdf();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      SystemChannels.platform.invokeMethod('SystemUiOverlay.setSystemUIOverlayStyle', const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ));
    }
  }

  Future<void> _downloadAndCachePdf() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/${widget.bookTitle}.pdf');

      if (await file.exists()) {
        setState(() => _localPdfPath = file.path);
      } else {
        final response = await http.get(Uri.parse(widget.pdfUrl));
        await file.writeAsBytes(response.bodyBytes);
        setState(() => _localPdfPath = file.path);
      }
    } catch (e) {
      print('Error caching PDF: $e');
      // Fallback to network loading
      setState(() => _localPdfPath = null);
    }
  }

  void _onItemTapped(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PdfViewerProvider(),
      child: Consumer<PdfViewerProvider>(
        builder: (context, pdfProvider, child) {
          return Theme(
            data: pdfProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            child: Scaffold(
              appBar: AppBar(
                title: Text(widget.bookTitle),
                actions: [
                  IconButton(
                    icon: Icon(pdfProvider.isDarkMode ? Icons.brightness_7 : Icons.brightness_4),
                    onPressed: pdfProvider.toggleDarkMode,
                  ),
                ],
              ),
              body: kIsWeb || _localPdfPath == null
                  ? SfPdfViewer.network(
                widget.pdfUrl,
                controller: _pdfViewerController,
                enableTextSelection: false,
                enableDocumentLinkAnnotation: false,
                enableHyperlinkNavigation: false,
                pageSpacing: 4,
                scrollDirection: PdfScrollDirection.vertical,
                canShowScrollHead: false,
                canShowPaginationDialog: false,
                initialZoomLevel: 1.0,
                interactionMode: PdfInteractionMode.pan,
                pageLayoutMode: pdfProvider.isDarkMode ? PdfPageLayoutMode.single : PdfPageLayoutMode.continuous,
              )
                  : Container(
                color: pdfProvider.isDarkMode ? Colors.black87 : Colors.white,
                child: SfPdfViewer.file(
                  File(_localPdfPath!),
                  controller: _pdfViewerController,
                  enableTextSelection: false,
                  enableDocumentLinkAnnotation: false,
                  enableHyperlinkNavigation: false,
                  pageSpacing: 4,
                  scrollDirection: PdfScrollDirection.vertical,
                  canShowScrollHead: false,
                  canShowPaginationDialog: false,
                  initialZoomLevel: 1.0,
                  interactionMode: PdfInteractionMode.pan,
                  pageLayoutMode: pdfProvider.isDarkMode ? PdfPageLayoutMode.single : PdfPageLayoutMode.continuous,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}