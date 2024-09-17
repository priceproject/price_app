import "package:price_app/features/utils/exports.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

class BooksDisplay extends StatefulWidget {
  const BooksDisplay({Key? key}) : super(key: key);

  @override
  State<BooksDisplay> createState() => _BooksDisplayState();
}

class _BooksDisplayState extends State<BooksDisplay> {
  List<BookModel> _books = [];
  bool _isLoading = false;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    setState(() => _isLoading = true);
    try {
      const url = 'https://seedapp.vercel.app/api/books';
      final response = await http.get(Uri.parse(url));

      print('Response status code: ${response.statusCode}');
      print('Raw response: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic jsonResponse = jsonDecode(response.body);
        print('Decoded response type: ${jsonResponse.runtimeType}');
        print('Decoded response: $jsonResponse');

        List<dynamic> booksData;
        if (jsonResponse is List) {
          booksData = jsonResponse;
        } else if (jsonResponse is Map && jsonResponse.containsKey('books')) {
          booksData = jsonResponse['books'] as List<dynamic>;
        } else {
          throw FormatException('Unexpected JSON structure');
        }

        setState(() {
          _books = booksData.map((json) => BookModel.fromJson(json as Map<String, dynamic>)).toList();
        });
        print('Number of books loaded: ${_books.length}');
      } else {
        throw Exception('Failed to load books. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching books: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load books. Please try again later.')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(
        title: 'Books',
        onSearch: (query) {
          setState(() {
            _isSearching = true;
          });
          Provider.of<SearchProvider>(context, listen: false).searchBooks(query);
        },
        onCancelSearch: () {
          setState(() {
            _isSearching = false;
          });
          _fetchBooks(); // Reload all books when search is cancelled
        },
      ),
      body: Stack(
        children: [
          _isSearching
              ? Consumer<SearchProvider>(
            builder: (context, searchProvider, child) {
              return _buildBookGrid(searchProvider.searchResults);
            },
          )
              : _buildBookGrid(_books),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF0B6F17),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBookGrid(List<BookModel> books) {
    return books.isEmpty
        ? const Center(child: Text('No books available'))
        : GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailsScreen(
                  bookId: book.id,
                ),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                book.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}