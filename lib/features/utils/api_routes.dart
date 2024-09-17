
class ApiRoutes{
static const String baseUrl = 'https:seedapp.vercel.app/api';
static const String registerEndpoint = '$baseUrl/user';
static const String loginEndpoint = '$baseUrl/user/login';
static const String newReleaseEndpoint = '$baseUrl/featured';
static const String searchEndpoint = '$baseUrl/search';
static const String allBookEndpoint = '$baseUrl/category';
static String categoryEndpoint(String category) => '$baseUrl/books?category=$category';
static const String suggestedEndpoint = '$baseUrl/suggested';
static const String studyBookEndpoint = '$baseUrl/suggested?category=study books';
static String bookByIdEndpoint(String id) => '$baseUrl/bookId/$id';
}