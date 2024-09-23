import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<bool> login(String email, String password) async {
    const String apiUrl = 'https://yourapi.com/login';  //api para el back y hacer el post para el login

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      return true; // Login exitoso
    } else {
      return false; // Login fallido
    }
  }
}
