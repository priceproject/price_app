class BookModel {
  final String id;


  final String title;
  final List<String> authors;
  final String aboutAuthor;
  final String aboutBook;
  final String imageUrl;
  final String? pdfUrl;
  final String contentText;
  final String category;
  final String price;
  final bool isFree;
  final bool isPurchased;
  final String numberOfPages;
  final String releaseYear;
  final String edition;
  final bool isAvailable;
  final DateTime createdAt;
  final DateTime updatedAt;

  BookModel({
    required this.id,
    required this.title,
    required this.authors,
    required this.aboutAuthor,
    required this.aboutBook,
    required this.imageUrl,
    this.pdfUrl,
    required this.contentText,
    required this.category,
    required this.price,
    required this.isFree,
    required this.isPurchased,
    required this.numberOfPages,
    required this.releaseYear,
    required this.edition,
    required this.isAvailable,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      authors: List<String>.from(json['authors'] ?? []),
      aboutAuthor: json['aboutAuthor'] ?? '',
      aboutBook: json['aboutBook'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      pdfUrl: json['pdfUrl'],
      contentText: json['contentText'] ?? '',
      category: json['category'] ?? '',
      price: json['price']?.toString() ?? '',
      isFree: json['isFree'] ?? false,
      isPurchased: json['isPurchased'] ?? false,
      numberOfPages: json['numberOfPages']?.toString() ?? '',
      releaseYear: json['releaseYear'] ?? '',
      edition: json['edition'] ?? '',
      isAvailable: json['isAvailable'] ?? false,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'BookModel(id: $id, title: $title, authors: $authors, category: $category, price: $price, isFree: $isFree)';
  }
}

class BookDetails {
  final String title;
  final String author;
  final String imageUrl;

  BookDetails({
    required this.title,
    required this.author,
    required this.imageUrl,
  });
}