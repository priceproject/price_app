import "package:price_app/features/utils/exports.dart";


class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  bool isSearching = false;
  int _currentIndex = 0;
  String _activeCategory= "All";



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
  void initState() {
    super.initState();
    combineBookLists();
  }


  Future<List<Map<String, dynamic>>> getSuggestedBooks() async {
    // Get the first 3 or 4 books from allBookData
    return allBookData.sublist(0, 4);
  }

  Future<List<Map<String, dynamic>>> getStudyMaterials() async {
    // Get the first 3 or 4 books from studyBookData
    return studyBookData.sublist(0, 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: !isSearching
            ? Text('Books')
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
      body: FutureBuilder(
        future: Future.wait([getSuggestedBooks(), getStudyMaterials()]),
        builder: (context, snapshot){
          if (snapshot.hasData){
            final suggestedBooks = snapshot.data![0];
            final studyMaterials = snapshot.data![1];
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    NewReleasedCard(),
                    SizedBox(height: 5),
                    BooksCategoryButton(
                      activeCategory: _activeCategory,
                      onCategorySelected: _onCategorySelected,
                    ),
                    SizedBox(height: 5),
                    BookCard(
                        title: 'Suggested for you',
                      books: suggestedBooks,
                      onArrowPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>AllBookScreen(),
                          ),);
                      },
                    ),
                    SizedBox(height: 20),
                    BookCard(
                      title: 'Study Materials',
                      books: studyMaterials,
                      onArrowPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>const StudyBookScreen(),
                        ),);
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}