import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lembra_mais/src/data/model/auth_model.dart';

class UserProvider {
  final http.Client httpClient = http.Client();
  final box = GetStorage();

  Future<Map<String, dynamic>> getUserDetails() async {
    try {
      var authData = box.read('auth');

      if (authData == null) {
        throw Exception("Auth não encontrado.");
      }

      if (authData is String) {
        authData = jsonDecode(authData);
      }

      if (authData is! Map<String, dynamic>) {
        throw Exception("Formato inesperado de dados no auth.");
      }

      var auth = Auth.fromJson(authData);

      String? token = auth.accessToken;
      int? userId = auth.user?.id;

      if (token == null || userId == null) {
        throw Exception("Token ou ID do usuário não encontrado.");
      }

      final response = await http.get(
        Uri.parse("http://192.168.200.100:8000/api/user/$userId"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erro ao buscar detalhes: ${response.statusCode}');
      }
    } catch (erro) {
      print('Erro durante o getUserDetails: $erro');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateUser(
    String nome,
    String dataNascimento,
    String? foto,
    String? telefone,
  ) async {
    try {
      var authData = Auth.fromJson(box.read('auth'));

      String? token = Auth.fromJson(box.read('auth')).accessToken;
      int? userId = authData.user?.id;

      if (token == null || userId == null) {
        throw Exception("Token ou ID do usuário não encontrado.");
      }

      final response = await http.put(
        Uri.parse("http://192.168.200.100:8000/api/user/$userId"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "nome": nome,
          "data_nascimento": dataNascimento,
          "foto": foto,
          "telefone": telefone,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Erro na solicitação: ${response.statusCode}, ${response.body}');
      }
    } catch (erro) {
      print('Erro durante o update: $erro');
      rethrow;
    }
  }
}
