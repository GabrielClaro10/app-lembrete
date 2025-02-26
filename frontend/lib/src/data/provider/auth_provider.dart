import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lembra_mais/src/data/model/auth_model.dart';

class AuthApiClient {
  final http.Client httpClient = http.Client();

  final box = GetStorage();

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

  Future<Map<String, dynamic>> register(
      String email,
      String password,
      String passwordConfirmation,
      String nome,
      String dataNascimento,
      String telefone) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.200.100:8000/api/register"),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Accept": "application/json",
        },
        body: {
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
          "nome": nome,
          "data_nascimento": dataNascimento,
          "telefone": telefone
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Erro na solicitação: ${response.statusCode}, ${response.body}');
      }
    } catch (erro) {
      print('Erro durante o registro: $erro');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> registerCompromissos(
    String local,
    String data,
    String descricao,
    String notificacao,
    String? status,
    String? obs,
    int idUsers,
    int idCategoria,
  ) async {
    try {
      String? token = Auth.fromJson(box.read('auth')).accessToken;

      if (token == null) {
        throw Exception("Token não encontrado.");
      }

      final response = await http.post(
        Uri.parse("http://192.168.200.100:8000/api/compromissos"),
        headers: {"Authorization": "Bearer $token"},
        body: {
          "local": local,
          "data": data,
          "descricao": descricao,
          "notificacao": notificacao,
          "status": status,
          "obs": obs,
          "id_users": idUsers.toString(),
          "id_categoria": idCategoria.toString(),
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Erro na solicitação: ${response.statusCode}, ${response.body}');
      }
    } catch (erro) {
      print('Erro durante o registro: $erro');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> registerCategoria(
    String nome,
    String status,
    int userId,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.200.100:8000/api/categoria"),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Accept": "application/json",
        },
        body: {
          "nome": nome,
          "status": status,
          "user_id": userId.toString(),
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Erro na solicitação: ${response.statusCode}, ${response.body}');
      }
    } catch (erro) {
      print('Erro durante o registro: $erro');
      rethrow;
    }
  }
}
