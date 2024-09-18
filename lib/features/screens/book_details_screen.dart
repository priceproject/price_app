import 'package:intl/intl.dart';
import 'package:price_app/features/utils/exports.dart';



class BookDetailsScreen extends StatefulWidget {
  final String bookId;

  const BookDetailsScreen({super.key, required this.bookId});

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  bool _showDescription = true;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookProvider>().fetchBookData(widget.bookId);
    });
  }
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _showAddedToCartDialog(bool isAddedToCart) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox.shrink(),
                  Padding(
                    padding: EdgeInsets.only(left: 32.w),
                    child: Container(
                      height: 5.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(2.5.r),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Image.asset(
                'images/added_to_cart.png',
                fit: BoxFit.contain,
              ),
              SizedBox(height: 16.h),
              Text(
                isAddedToCart ? 'Added to Cart' : 'Added to Library',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the bottom sheet
                  if (isAddedToCart) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/cart_zero',
                          (route) => false,
                    );
                  } else {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/library',
                          (route) => false,
                    );
                  }
                },

                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFF0B6F17),
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF0B6F17)),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                ),
                child: Text(isAddedToCart ? 'View Cart Items' : 'Continue'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookProvider>(
      builder: (context, bookProvider, child) {
        final book = bookProvider.currentBook;
        final isLoading = bookProvider.isLoading;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF0B6F17),
            elevation: 200,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(book?.title ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),),
          ),
          body: isLoading
              ? const Center(child: CircularProgressIndicator(
            color: Color(0xFF0B6F17),
          ))
              : SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Image.network(
                          book?.imageUrl ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book?.title ?? '',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              book?.authors.join(', ') ?? '',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Price: ${_formatPrice(book?.price)}',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            _buildActionButtons(book, bookProvider),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: 16.h),
                  // _buildActionButtons(book, bookProvider),
                  SizedBox(height: 40.h),
                  _buildDescriptionAuthorToggle(),
                  SizedBox(height: 16.h),
                  _showDescription
                      ? _buildExpandableText(book?.aboutBook ?? '')
                      : _buildExpandableText(book?.aboutAuthor ?? ''),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  Widget _buildActionButtons(BookModel? book, BookProvider bookProvider) {
    bool isFree = book?.price == null ||
        book?.price.trim().toLowerCase() == 'free' ||
        book?.price == '0' ||
        book!.price.trim().isEmpty;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 30.h,
          child: ElevatedButton(
            onPressed: () => _navigateToPreviewPage(book),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF0B6F17),
              side: const BorderSide(color: Color(0xFF0B6F17)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.r),
              ),
            ),
            child: const Text('Preview'),
          ),
        ),
        SizedBox(height: 6.h),
        SizedBox(
          width: double.infinity,
          height: 30.h,
          child: ElevatedButton(
            onPressed: () async {
              if (book?.pdfUrl == null) {
                _showErrorSnackBar('Book not available. Please check later.');
                return;
              }
              try {
                if (isFree) {
                  await bookProvider.addBookToLibrary(book!.id);
                } else {
                  await bookProvider.addBookToCart(book!.id);
                }

                if (bookProvider.error == null) {
                  _showAddedToCartDialog(!isFree);
                } else {
                  if (bookProvider.error!.contains('already in cart')) {
                    _showErrorSnackBar('Book already in Cart', isAlreadyInCart: true);
                  } else if (bookProvider.error!.contains('already in library')) {
                    _showErrorSnackBar('Book already in Library', isAlreadyInLibrary: true);
                  } else {
                    _showErrorSnackBar(bookProvider.error!);
                  }
                }
              } catch (e) {
                _showErrorSnackBar('An error occurred. Please try again.');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF0B6F17),
              side: const BorderSide(color: Color(0xFF0B6F17)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.r),
              ),
            ),
            child: Text(isFree ? 'Add to Library' : 'Add to Cart'),
          ),
        ),
      ],
    );
  }
  // Widget _buildActionButtons(BookModel? book, BookProvider bookProvider) {
  //   return Column(
  //     children: [
  //       SizedBox(
  //         width: double.infinity,
  //         height: 30.h,
  //         child: ElevatedButton(
  //           onPressed: () => _navigateToPreviewPage(book),
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: Colors.white,
  //             foregroundColor: const Color(0xFF0B6F17),
  //             side: const BorderSide(color: Color(0xFF0B6F17)),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(5.r),
  //             ),
  //           ),
  //           child: const Text('Preview'),
  //         ),
  //       ),
  //       SizedBox(height: 6.h),
  //       SizedBox(
  //         width: double.infinity,
  //         height: 30.h,
  //         child: ElevatedButton(
  //           onPressed: () async {
  //
  //             if (book?.pdfUrl == null) {
  //               _showErrorSnackBar('Book not available. Please check later.');
  //               return;
  //             }
  //             try {
  //               if (book?.price != null && book?.price != 'free') {
  //                 await bookProvider.addBookToCart(book!.id);
  //               } else {
  //                 await bookProvider.addBookToLibrary(book!.id);
  //               }
  //
  //               if (bookProvider.error == null) {
  //                 _showAddedToCartDialog(book!.price != 'free');
  //               } else {
  //                 if (bookProvider.error!.contains('already in cart')) {
  //                   _showErrorSnackBar('Book already in Cart', isAlreadyInCart: true);
  //                 } else if (bookProvider.error!.contains('already in library')) {
  //                   _showErrorSnackBar('Book already in Library', isAlreadyInLibrary: true);
  //                 } else {
  //                   _showErrorSnackBar(bookProvider.error!);
  //                 }
  //               }
  //             } catch (e) {
  //               _showErrorSnackBar('An error occurred. Please try again.');
  //             }
  //           },
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: Colors.white,
  //             foregroundColor: const Color(0xFF0B6F17),
  //             side: const BorderSide(color: Color(0xFF0B6F17)),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(5.r),
  //             ),
  //           ),
  //           child: Text(book?.price != null && book?.price != 'free'
  //               ? 'Add to Cart'
  //               : 'Add to Library'),
  //         ),
  //       ),
  //     ],
  //   );
  // }


  void _showErrorSnackBar(String message, {bool? isAlreadyInCart, bool? isAlreadyInLibrary}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Expanded(child: Text(message)),
            if (isAlreadyInCart == true || isAlreadyInLibrary == true)
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    isAlreadyInCart == true ? '/cart_zero' : '/library',
                        (route) => false,
                  );
                },
                child: Text(
                  isAlreadyInCart == true ? 'View Cart' : 'View Library',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
        backgroundColor: isAlreadyInCart == true || isAlreadyInLibrary == true ? Color(0xFF0B6F17) : Colors.red,
        duration: Duration(seconds: 4),
      ),
    );
  }

  Widget _buildDescriptionAuthorToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => setState(() => _showDescription = true),
              style: ElevatedButton.styleFrom(
                backgroundColor: _showDescription ? const Color(0xFF0B6F17) : Colors.white,
                foregroundColor: _showDescription ? Colors.white : const Color(0xFF0B6F17),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
              child: const Text('Show Description'),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: ElevatedButton(
              onPressed: () => setState(() => _showDescription = false),
              style: ElevatedButton.styleFrom(
                backgroundColor: _showDescription ? Colors.white : const Color(0xFF0B6F17),
                foregroundColor: _showDescription ? const Color(0xFF0B6F17) : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
              child: const Text('About Author'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableText(String text) {
    return Container(
      padding: EdgeInsets.all(12.0),
      color: Colors.white70,
      child: SizedBox(
        height: 200.h,
        child: SingleChildScrollView(
          child: Text(
            textAlign: TextAlign.justify,
            text,
            style: TextStyle(fontSize: 16.sp),
          ),
        ),
      ),
    );
  }

  String _formatPrice(String? price) {
    if (price == null || price.isEmpty || price.toLowerCase() == 'free') {
      return 'Free';
    }

    try {
      final formatter = NumberFormat.currency(symbol: '₦', decimalDigits: 2);
      return formatter.format(double.parse(price));
    } catch (e) {
      // If parsing fails, return the original string
      return price;
    }
  }

  void _navigateToPreviewPage(BookModel? book) {
    if (book != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BookPreviewPage(book: book),
        ),
      );
    }
  }
}


class BookPreviewPage extends StatefulWidget {
  final BookModel book;
  final int maxPages;

  const BookPreviewPage({super.key, required this.book, this.maxPages = 10});

  @override
  State<BookPreviewPage> createState() => _BookPreviewPageState();
}

class _BookPreviewPageState extends State<BookPreviewPage> {
  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
  }

  void _showErrorSnackBar(String message, {bool? isAlreadyInCart, bool? isAlreadyInLibrary}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Expanded(child: Text(message)),
            if (isAlreadyInCart == true || isAlreadyInLibrary == true)
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    isAlreadyInCart == true ? '/cart_zero' : '/library',
                        (route) => false,
                  );
                },
                child: Text(
                  isAlreadyInCart == true ? 'View Cart' : 'View Library',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
        backgroundColor: isAlreadyInCart == true || isAlreadyInLibrary == true ? Color(0xFF0B6F17) : Colors.red,
        duration: Duration(seconds: 4),
      ),
    );
  }

  void _showAddedToCartDialog(bool isAddedToCart) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Expanded(
              child: Text(
                isAddedToCart ? 'Added to Cart' : 'Added to Library',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  isAddedToCart ? '/cart_zero' : '/library',
                      (route) => false,
                );
              },
              child: Text(
                isAddedToCart ? 'View Cart' : 'View Library',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF0B6F17),
        duration: Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B6F17),
        elevation: 200,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Preview: ${widget.book.title}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: widget.book.pdfUrl != null && widget.book.pdfUrl!.isNotEmpty
          ? Column(
        children: [
          Expanded(
            child: SfPdfViewer.network(
              widget.book.pdfUrl!,
              controller: _pdfViewerController,
              enableDoubleTapZooming: true,
              canShowScrollHead: false,
              canShowPaginationDialog: false,
              canShowScrollStatus: false,
              pageLayoutMode: PdfPageLayoutMode.single,
              interactionMode: PdfInteractionMode.pan,
              scrollDirection: PdfScrollDirection.vertical,
              enableTextSelection: false,
              onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                if (details.document.pages.count > widget.maxPages) {
                  Future.delayed(Duration.zero, () {
                    _pdfViewerController.jumpToPage(widget.maxPages);
                  });
                }
              },
              onPageChanged: (PdfPageChangedDetails details) {
                if (details.newPageNumber > widget.maxPages) {
                  _pdfViewerController.jumpToPage(widget.maxPages);
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF0B6F17),
                    side: const BorderSide(color: Color(0xFF0B6F17)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back to Details',
                  style: TextStyle(
                    color: Color(0xFF0B6F17),
                  )),
                ),
                Consumer<BookProvider>(
                  builder: (context, bookProvider, child) {
                    bool isFree = widget.book.price == null ||
                        widget.book.price.trim().toLowerCase() == 'free' ||
                        widget.book.price == '0' ||
                        widget.book.price.trim().isEmpty;

                    return ElevatedButton(
                      onPressed: () async {
                        try {
                          if (isFree) {
                            await bookProvider.addBookToLibrary(widget.book.id);
                          } else {
                            await bookProvider.addBookToCart(widget.book.id);
                          }

                          if (bookProvider.error == null) {
                            _showAddedToCartDialog(!isFree);
                          } else {
                            if (bookProvider.error!.contains('already in cart')) {
                              _showErrorSnackBar('Book already in Cart', isAlreadyInCart: true);
                            } else if (bookProvider.error!.contains('already in library')) {
                              _showErrorSnackBar('Book already in Library', isAlreadyInLibrary: true);
                            } else {
                              _showErrorSnackBar(bookProvider.error!);
                            }
                          }
                        } catch (e) {
                          _showErrorSnackBar('An error occurred. Please try again.');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF0B6F17),
                        side: const BorderSide(color: Color(0xFF0B6F17)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                      child: Text(isFree ? 'Add to Library' : 'Add to Cart'),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      )
          : const Center(
        child: Text('Preview not available for this book.'),
      ),
    );
  }
}