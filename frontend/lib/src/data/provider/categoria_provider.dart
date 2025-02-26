import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lembra_mais/src/data/model/auth_model.dart';

class CategoriaApiClient {
  final http.Client httpClient = http.Client();

  final box = GetStorage();

  Future<dynamic> getCategoria() async {
    try {
      String? token = Auth.fromJson(box.read('auth')).accessToken;

      if (token == null) {
        throw Exception("Token não encontrado.");
      }

      var response = await http.get(
        Uri.parse("http://192.168.200.100:8000/api/categoria"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Retorna o JSON já convertido
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

  Future<dynamic> deleteCategoria(int userId) async {
    try {
      String? token = Auth.fromJson(box.read('auth')).accessToken;

      if (token == null) {
        throw Exception("Token não encontrado.");
      }

      var response = await http.delete(
        Uri.parse("http://192.168.200.100:8000/api/categoria/$userId"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Retorna o JSON já convertido
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
}
