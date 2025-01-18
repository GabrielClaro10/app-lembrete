import 'package:lembra_mais/src/data/model/auth_model.dart';
import 'package:lembra_mais/src/data/model/user_model.dart';
import 'package:lembra_mais/src/data/provider/auth_provider.dart';

class AuthRepository {
  final AuthApiClient apiClient = AuthApiClient();

  Future<Auth> login(String email, String password) async {
    return Auth.fromJson(await apiClient.login(email, password));
  }

  Future<User> register(
      String email,
      String password,
      String passwordConfirmation,
      String nome,
      String dataNascimento,
      String telefone) async {
    return User.fromJson(await apiClient.register(
        email, password, passwordConfirmation, nome, dataNascimento, telefone));
  }
}
