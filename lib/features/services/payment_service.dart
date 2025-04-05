import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:price_app/features/utils/api_routes.dart';

class PaymentService {
  Future<Map<String, dynamic>> initializePayment({
    required String token,
    required double amount,
    required String email,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required List<dynamic> cartBooks,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiRoutes.initializePaymentEndpoint),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'amount': amount,
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'phoneNumber': phoneNumber,
          'cartBooks': cartBooks,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to initialize payment: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error initializing payment: $e');
    }
  }

  Future<Map<String, dynamic>> verifyPayment({
    required String token,
    required String transactionId,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiRoutes.verifyPaymentEndpoint}/$transactionId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to verify payment: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error verifying payment: $e');
    }
  }
}
