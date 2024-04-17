import "package:price_app/features/utils/exports.dart";




class BookDetailsScreen extends StatefulWidget {
  final String bookImageUrl;
  final String bookTitle;
  final double bookPrice;
  final String bookDescription;
  final String bookAuthor;
  final String aboutAuthor;

  const BookDetailsScreen({
    Key? key,
    required this.bookImageUrl,
    required this.bookTitle,
    required this.bookPrice,
    required this.bookDescription,
    required this.bookAuthor,
    required this.aboutAuthor,
  }) : super(key: key);

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  bool showAuthorInfo = false;
  bool showDescription = false;
  bool showAddedToCartDialog = false;


  void _showAddedToCartDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Added to Cart',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Image.asset(
                widget.bookImageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the cart screen
                  Navigator.of(context).pop();
                },
                child: Text('View Cart'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(widget.bookTitle),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 300,
                  child: Image.asset(
                    widget.bookImageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 8.0,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.bookTitle,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        //overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        widget.bookAuthor,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Price: \# ${widget.bookPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            //SizedBox(height: 8.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showAddedToCartDialog();
                },
                child: Text('Add to Cart'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showAuthorInfo = !showAuthorInfo;
                        showDescription = false;
                      });
                    },
                    child: Text('About the Author',
                    style: TextStyle(
                      color: Colors.black,
                    ),),
                  ),
                ),
                SizedBox(width: 4.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showDescription = !showDescription;
                        showAuthorInfo = false;
                      });
                    },
                    child: Text('Description',
                    style: TextStyle(
                      color: Colors.black,
                    ),),
                  ),
                ),
              ],
            ),
            if (showAuthorInfo)
              Padding(
                padding:EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    widget.aboutAuthor,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            if (showDescription)
              Text(
                widget.bookDescription,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
          ],
        ),
      ),
    );
  }
}