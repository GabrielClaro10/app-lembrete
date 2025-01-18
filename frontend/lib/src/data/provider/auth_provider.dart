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
    String tipoCompromisso,
    String local,
    String data,
    bool repetirAlarme,
    String descricao,
    String notificacao,
    String? status,
    String? obs,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.200.100:8000/api/compromissos"),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Accept": "application/json",
        },
        body: {
          "tipoCompromisso": tipoCompromisso,
          "local": local,
          "data": data,
          "repetirAlarme": repetirAlarme,
          "descricao": descricao,
          "notificacao": notificacao,
          "status": status,
          "obs": obs
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
