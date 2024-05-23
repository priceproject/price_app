import "package:price_app/features/utils/exports.dart";



class BookCard extends StatelessWidget {
  BookCard({
    required this.title,
    required this.books,
    required this.onArrowPressed,
  });

  final String title;
  final List<Map<String, dynamic>> books;
  final VoidCallback onArrowPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      color: Colors.white,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
          ),
          SizedBox(height: 15,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for ( final book in books)
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookDetailsScreen(
                                    bookImageUrl: book['imageUrl'],
                                    bookTitle: book['title'],
                                    bookPrice: book['price'],
                                    bookDescription: book['description'],
                                    bookAuthor: book['author'],
                                    aboutAuthor: book['about the author'],
                                  ),
                          ),
                      );
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: SizedBox(
                            width: 100.0,
                              height: 150.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                  child:Image.asset(
                                    book['imageUrl'],
                                    fit: BoxFit.cover,
                                  ),
                              ),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(width: 8,),
                IconButton(
                    onPressed: onArrowPressed,
                    icon: Icon(
                      Icons.arrow_forward,
                      size: 100,
                      weight: 150,
                      color: Colors.grey,

                ))


              ],

            ),
          ),

        ],
      ),
    );
  }
}