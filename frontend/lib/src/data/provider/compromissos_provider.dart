import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lembra_mais/src/data/model/auth_model.dart';

class CompromissosApiClient {
  final http.Client httpClient = http.Client();

  final box = GetStorage();

  Future<dynamic> buscarCompromisso() async {
    try {
      String? token = Auth.fromJson(box.read('auth')).accessToken;

      if (token == null) {
        throw Exception("Token não encontrado.");
      }

      var response = await http.get(
        Uri.parse("http://64.181.179.120/api/compromissos"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          'Erro na solicitação: ${response.statusCode}, ${response.body}',
        );
      }
    } catch (erro) {
      print('Erro ao obter categorias: $erro');
      rethrow;
    }
  }

  Future<dynamic> deletarCompromisso(int compromissoId) async {
    try {
      String? token = Auth.fromJson(box.read('auth')).accessToken;

      if (token == null) {
        throw Exception("Token não encontrado.");
      }

      var response = await http.delete(
        Uri.parse("http://64.181.179.120/api/compromissos/$compromissoId"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          'Erro na solicitação: ${response.statusCode}, ${response.body}',
        );
      }
    } catch (erro) {
      print('Erro ao obter compromisso: $erro');
      rethrow;
    }
  }
}
