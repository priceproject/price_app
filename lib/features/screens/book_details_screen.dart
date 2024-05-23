import "package:price_app/features/utils/exports.dart";




class BookDetailsScreen extends StatefulWidget {
  final String bookImageUrl;
  final String bookTitle;
  final String bookPrice;
  final String bookDescription;
  final String bookAuthor;
  final String aboutAuthor;

  const BookDetailsScreen({
    super.key,
    required this.bookImageUrl,
    required this.bookTitle,
    required this.bookPrice,
    required this.bookDescription,
    required this.bookAuthor,
    required this.aboutAuthor,
  });

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  bool showAuthorInfo = false;
  bool showDescription = false;
  bool showAddedToCartDialog = false;
  Color descriptionColor = Colors.green;
  int _currentIndex = 0;


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
                children: [
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
                'images/Cart Images/Checkmark.png',
                fit: BoxFit.contain,
              ),
              SizedBox(height: 16.0),
              Text(
                'Added to Cart',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartOne()),
                  );
                },
                child: Text('View Cart Items'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.green,
                  backgroundColor: Colors.white,
                  side:BorderSide(
                    color: Colors.green
                  ),
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

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    navigateToScreen(context, index);
    // Add your navigation logic here
  }


  @override
  void initState() {
    super.initState();
    showDescription = true; // Show description content by default
    descriptionColor = Colors.green; // Set the initial color for description
  }


  void toggleContent(bool isDescription) {
    setState(() {
      if (isDescription) {
        showDescription = true;
        showAuthorInfo = false;
        descriptionColor = Colors.green;
      } else {
        showDescription = false;
        showAuthorInfo = true;
        descriptionColor = Colors.blue; // Color for About the Author
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.bookTitle),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          widget.bookPrice,
                          style: TextStyle(
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
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    _showAddedToCartDialog();
                  },
                  child: Text('Add to Cart'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.green,
                    side: BorderSide(
                      color: Colors.green,
                      style: BorderStyle.solid,
                    ),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        toggleContent(true);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: showDescription ? Colors.grey : Colors.white,
                        foregroundColor: showDescription ? Colors.white : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      child: Text('Description',
                        style: TextStyle(
                          color: Colors.black,
                        ),),
                    ),
                  ),
                  SizedBox(width: 4.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        toggleContent(false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: showAuthorInfo ? Colors.grey : Colors.white,
                        foregroundColor: showAuthorInfo ? Colors.white : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      child: Text('About the Author',
                      style: TextStyle(
                        color: Colors.black,
                      ),),
                    ),
                  ),


                ],
              ),
              if (showAuthorInfo)
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
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
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      widget.bookDescription,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}