import 'package:price_app/features/utils/exports.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final Function(String) onSearch;
  final VoidCallback onCancelSearch;

  const SearchAppBar({
    super.key,
    required this.title,
    required this.onSearch,
    required this.onCancelSearch,
    this.height = kToolbarHeight,
  });

  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: !isSearching
          ? Text(widget.title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),)
          : TextField(
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        controller: _searchController,
        decoration: InputDecoration(
          iconColor: Colors.white,
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          hintText: 'Search here',
          hintStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16
          ),
          icon: GestureDetector(
            onTap: () {
              _performSearch();
            },
            child: const Icon(Icons.search),
          ),
        ),
        onSubmitted: (_) => _performSearch(),
      ),
      backgroundColor: const Color(0xFF0B6F17),
      elevation: 200,
      actions: [
        isSearching
            ? IconButton(
          color: Colors.white,
          onPressed: () {
            setState(() {
              isSearching = false;
              _searchController.clear();
            });
            widget.onCancelSearch();
          },
          icon: const Icon(Icons.cancel_outlined),
        )
            : IconButton(
          color: Colors.white,
          onPressed: () {
            setState(() {
              isSearching = true;
            });
          },
          icon: const Icon(Icons.search,color: Colors.white,),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/cart_zero');
          },
          icon: const Icon(Icons.shopping_cart,color: Colors.white,),
        ),
      ],
    );
  }
  void _performSearch() {
    print('Performing search with query: ${_searchController.text}');
    widget.onSearch(_searchController.text);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
