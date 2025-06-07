import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lembra_mais/src/data/model/auth_model.dart';
import 'package:lembra_mais/src/data/model/user_model.dart';

class AuthApiClient {
  final http.Client httpClient = http.Client();

  final box = GetStorage();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/login"),
        body: {"email": email, "password": password},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Erro na solicitação: ${response.statusCode}, ${response.body}');
      }
    } catch (erro) {
      Get.snackbar(
        "Erro",
        "Credenciais incorretas. Verifique seu e-mail e senha.",
        colorText: Colors.white,
        backgroundColor: Colors.red[300],
        messageText: const Text(
          "Credenciais incorretas. Verifique seu e-mail e senha.",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      );
      rethrow;
    }
  }

  Future<Auth> registrar(
      String email,
      String password,
      String passwordConfirmation,
      String nome,
      String dataNascimento,
      String telefone) async {
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/register"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode({
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
          "nome": nome,
          "data_nascimento": dataNascimento,
          "telefone": telefone,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);

        final user = User.fromJson(data['user']);

        final auth = Auth(
          user: user,
          accessToken: data['access_token'],
          tokenType: data['token_type'],
          expiresIn: data['expires_in'],
        );
        return auth;
      } else {
        throw Exception(
            'Erro na solicitação: ${response.statusCode}, ${response.body}');
      }
    } catch (erro) {
      print('Erro durante o registro: $erro');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> esqueciSenha(String email) async {
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/esqueci-senha"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode({
          "email": email,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Erro na solicitação: ${response.statusCode}, ${response.body}');
      }
    } catch (erro) {
      print('Erro durante a recuperação de senha: $erro');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> registrarCompromisso(
    String local,
    String data,
    String descricao,
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
        Uri.parse("http://10.0.2.2:8000/api/compromissos"),
        headers: {"Authorization": "Bearer $token"},
        body: {
          "local": local,
          "data": data,
          "descricao": descricao,
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

  Future<Map<String, dynamic>> registrarCategoria(
    String nome,
    String status,
    int userId,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/categoria"),
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

  Future<Map<String, dynamic>> resetarSenha(String email) async {
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/forgot-password"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode({
          "email": email,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Erro na solicitação: ${response.statusCode}, ${response.body}');
      }
    } catch (erro) {
      print('Erro durante o reset de senha: $erro');
      rethrow;
    }
  }
}
