import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lembra_mais/src/data/model/auth_model.dart';

class UserProvider {
  final http.Client httpClient = http.Client();
  final box = GetStorage();

  Future<Map<String, dynamic>> buscarUsuarioDetalhes() async {
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
        Uri.parse("http://10.0.2.2:8000/api/user/$userId"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData.containsKey("user")) {
          return responseData["user"];
        } else {
          throw Exception("Chave 'user' não encontrada na resposta da API.");
        }
      } else {
        throw Exception('Erro ao buscar detalhes: ${response.statusCode}');
      }
    } catch (erro) {
      print('Erro durante o getUserDetails: $erro');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> alterarUsuario(
    String nome,
    String dataNascimento,
    String? foto,
    String? telefone,
  ) async {
    try {
      var authData = Auth.fromJson(box.read('auth'));
      String? token = authData.accessToken;
      int? userId = authData.user?.id;

      if (token == null || userId == null) {
        throw Exception("Token ou ID do usuário não encontrado.");
      }

      var uri = Uri.parse("http://10.0.2.2:8000/api/user/$userId");

      var response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: {
          '_method': 'PUT',
          'nome': nome,
          'data_nascimento': dataNascimento,
          'telefone': telefone ?? '',
          'foto': foto ?? '',
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Erro: ${response.statusCode}, ${response.body}');
      }

      return json.decode(response.body);
    } catch (erro) {
      print('Erro durante o update: $erro');
      rethrow;
    }
  }

  Future<String> uploadImagemParaServidor(String filePath) async {
    try {
      var authData = box.read('auth');

      if (authData is String) {
        authData = jsonDecode(authData);
      }
      var auth = Auth.fromJson(authData);

      String? token = auth.accessToken;

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.0.2.2:8000/api/upload'),
      );
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      var multipartFile = await http.MultipartFile.fromPath('foto', filePath);
      request.files.add(multipartFile);

      var response = await request.send();

      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(responseBody);
        return jsonResponse['path'];
      } else {
        throw Exception(
            'Falha no upload com status code ${response.statusCode}');
      }
    } catch (e) {
      print('Erro no uploadImagemParaServidor: $e');
      rethrow;
    }
  }
}
