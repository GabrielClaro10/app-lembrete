import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static const String _baseUrl = 'http://127.0.0.1:8000/api/users';

  static Future<void> createUser(String nome, String dataNascimento,
      String email, String telefone, int tema) async {
    const String url = '$_baseUrl/usuarios';

    final Map<String, dynamic> body = {
      'nome': nome,
      'data_nascimento': dataNascimento,
      'email': email,
      'telefone': telefone,
      'tema': tema,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 201) {
        print('Usuário criado com sucesso: ${response.body}');
      } else {
        print('Erro ao criar usuário: ${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print('Erro: $e');
    }
  }
}
