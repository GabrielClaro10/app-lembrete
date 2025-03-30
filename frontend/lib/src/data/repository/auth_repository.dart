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

  Future<Auth> register(
      String email,
      String password,
      String passwordConfirmation,
      String nome,
      String dataNascimento,
      String telefone) async {
    try {
      final Auth authResponse = await apiClient.register(email, password,
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

  Future<User> updateUser(String nome, String dataNascimento, String? foto,
      String? telefone) async {
    final response =
        await userProvider.updateUser(nome, dataNascimento, foto, telefone);
    return User.fromJson(response);
  }

  Future<User> getUserDetails() async {
    var response = await userProvider.getUserDetails();
    return User.fromJson(response);
  }

  // Novo método para recuperação de senha
  Future<Map<String, dynamic>> esqueciSenha(String email) async {
    try {
      final result = await apiClient.esqueciSenha(email);
      return result;
    } catch (erro) {
      print('Erro durante a recuperação de senha: $erro');
      rethrow;
    }
  }
}
