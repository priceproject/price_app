class ApiRoutes {
  static const String baseUrl = 'https://seedapp-backend.vercel.app/api';
  static const String registerEndpoint = '$baseUrl/user';
  static const String loginEndpoint = '$baseUrl/user/login';
  static const String newReleaseEndpoint = '$baseUrl/featured';
  static const String searchEndpoint = '$baseUrl/search';
  static const String allBookEndpoint = '$baseUrl/category';
  static String categoryEndpoint(String category) =>
      '$baseUrl/books?category=$category';
  static const String suggestedEndpoint = '$baseUrl/suggested';
  static const String studyBookEndpoint =
      '$baseUrl/suggested?category=study books';
  static String bookByIdEndpoint(String id) => '$baseUrl/bookId/$id';

// Auth endpoints
  static const String verifyOTPEndpoint = '$baseUrl/auth/verifyOTP';
  static const String forgetPasswordEndpoint = '$baseUrl/auth/forgetPassword';

// Payment endpoints
  static const String initializePaymentEndpoint =
      'https://seedapp-backend.vercel.app/api/payment/initialize';
  static const String verifyPaymentEndpoint =
      'https://seedapp-backend.vercel.app/api/payment/verify';

// Other endpoints
  static const String viewCartEndpoint = '$baseUrl/viewCart';
  static const String addToLibraryEndpoint = '$baseUrl/addToLibrary';
  static const String userProfileEndpoint = '$baseUrl/user/profile';
}
