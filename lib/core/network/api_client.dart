import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../storage/token_storage.dart';
import 'api_exception.dart';

class ApiClient {
  static Future<Map<String, String>> _headers() async {
    final token = await TokenStorage.getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<dynamic> get(String path) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/$path'),
      headers: await _headers(),
    );
    return _handleResponse(response);
  }

  static Future<dynamic> post(String path, [Map<String, dynamic>? body]) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/$path'),
      headers: await _headers(),
      body: body != null ? jsonEncode(body) : null,
    );
    return _handleResponse(response);
  }

  static Future<dynamic> put(String path, [Map<String, dynamic>? body]) async {
    final response = await http.put(
      Uri.parse('${ApiConstants.baseUrl}/$path'),
      headers: await _headers(),
      body: body != null ? jsonEncode(body) : null,
    );
    return _handleResponse(response);
  }

  static Future<dynamic> delete(String path) async {
    final response = await http.delete(
      Uri.parse('${ApiConstants.baseUrl}/$path'),
      headers: await _headers(),
    );
    return _handleResponse(response);
  }

  static dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 204) return null;

    final decoded = response.body.isNotEmpty ? jsonDecode(response.body) : null;

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded;
    }

    final message = decoded is Map && decoded['message'] != null
        ? decoded['message'] as String
        : 'Something went wrong (${response.statusCode})';

    final errors = decoded is Map && decoded['errors'] is Map
        ? Map<String, dynamic>.from(decoded['errors'])
        : null;

    throw ApiException(response.statusCode, message, errors: errors);
  }
}