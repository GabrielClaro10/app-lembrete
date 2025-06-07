import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:lembra_mais/src/data/model/auth_model.dart';
import 'package:lembra_mais/src/data/model/user_model.dart';
import 'package:lembra_mais/src/data/provider/auth_provider.dart';
import 'package:lembra_mais/src/data/provider/user_provider.dart';

class AuthRepository {
  final AuthApiClient apiClient = AuthApiClient();
  final UserProvider userProvider = UserProvider();
  final box = GetStorage();

  Future<Auth> login(String email, String password) async {
    final data = await apiClient.login(email, password);
    if (data.containsKey('access_token')) {
      box.write('auth', data['access_token']);
    }
    return Auth.fromJson(data);
  }

  Future<Auth> registrar(
      String email,
      String password,
      String passwordConfirmation,
      String nome,
      String dataNascimento,
      String telefone) async {
    try {
      final Auth authResponse = await apiClient.registrar(email, password,
          passwordConfirmation, nome, dataNascimento, telefone);

      if (authResponse.accessToken != null && authResponse.user != null) {
        box.write('auth', authResponse.toJson());
        return authResponse;
      } else {
        throw Exception('Falha ao registrar usuário ou obter token.');
      }
    } catch (error) {
      print('Erro ao registrar: $error');
      rethrow;
    }
  }

  Future<User> alterarUsuario(String nome, String dataNascimento, String? foto,
      String? telefone) async {
    final response =
        await userProvider.alterarUsuario(nome, dataNascimento, foto, telefone);
    return User.fromJson(response);
  }

  Future<User> buscarUsuarioDetalhes() async {
    var response = await userProvider.buscarUsuarioDetalhes();
    return User.fromJson(response);
  }

  Future<Map<String, dynamic>> resetarSenha(String email) async {
    try {
      final response = await apiClient.resetarSenha(email);
      return response;
    } catch (e) {
      print('Erro ao enviar reset password: $e');
      rethrow;
    }
  }

  Future<String?> uploadFoto(File file) async {
    try {
      return await userProvider.uploadImagemParaServidor(file.path);
    } catch (e) {
      print('Erro no uploadFoto: $e');
      return null;
    }
  }
}
