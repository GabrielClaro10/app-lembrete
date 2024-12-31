import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthApiClient {
  final http.Client httpClient = http.Client();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.200.100:8000/api/login"),
        body: {"email": email, "password": password},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Erro na solicitação: ${response.statusCode}, ${response.body}');
      }
    } catch (erro) {
      print('Erro durante o login: $erro');
      rethrow;
    }
  }
}
