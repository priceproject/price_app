import "package:price_app/features/utils/exports.dart";


class AllBookScreen extends StatefulWidget {
  const AllBookScreen({super.key});

  @override
  State<AllBookScreen> createState() => _AllBookScreenState();
}

class _AllBookScreenState extends State<AllBookScreen> {

  bool isSearching = false;
  int _currentIndex = 0;

  String _activeCategory = "All";

  @override
  void initState() {
    super.initState();
    combineBookLists();
  }


  void _onCategorySelected(String category) {
    setState(() {
      _activeCategory = category;
    });
    navigateToBookScreen(context, _activeCategory);
    // Add navigation logic based on the selected category
    // For example, if category == "Study", navigate to StudyScreen
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Add your navigation logic here
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: !isSearching
            ? Text('Discover',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),)
            : TextField(
          decoration: InputDecoration(
            hintText: 'search here',
            icon: GestureDetector(
                onTap: () {
                  print("I'm searching");
                },
                child: Icon(Icons.search)),
          ),
        ),
        // backgroundColor: Color(0xffE1E1E1FF),
        actions: [
          isSearching
              ? IconButton(
            onPressed: () {
              setState(() {
                this.isSearching = false;
              });
            },
            icon: Icon(Icons.cancel_outlined),
          )
              : IconButton(
            onPressed: () {
              setState(() {
                this.isSearching = true;
              });
            },
            icon: Icon(Icons.search),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Container(
              color: Colors.white,
              child: BooksCategoryButton(
                activeCategory: _activeCategory,
                onCategorySelected: _onCategorySelected,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ScreenUtil().orientation ==
                        Orientation.portrait ? 2 : 4,
                    crossAxisSpacing: 8.w,
                    mainAxisSpacing: 20.h,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: allBookData.length,
                  itemBuilder: (context, index) {
                    final book = allBookData[index];
                    return GestureDetector(
                      onTap: () {
                        print('welcome to bookpage');
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (context) =>
                                BookDetailsScreen(
                                    bookImageUrl: book['imageUrl'],
                                    bookPrice: book['price'],
                                    bookDescription: book['description'],
                                    bookAuthor: book['author'],
                                    bookTitle: book['title'],
                                    aboutAuthor: book['about the author']

                                ))
                        );
                      },
                      child: SizedBox(
                        height: 100,
                        child: Image.asset(
                          book['imageUrl'],
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
