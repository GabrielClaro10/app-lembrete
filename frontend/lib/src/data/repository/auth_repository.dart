import 'package:lembra_mais/src/data/model/auth_model.dart';
import 'package:lembra_mais/src/data/model/user_model.dart';
import 'package:lembra_mais/src/data/provider/auth_provider.dart';
import 'package:lembra_mais/src/data/provider/user_provider.dart';

class AuthRepository {
  final AuthApiClient apiClient = AuthApiClient();
  final UserProvider userProvider = UserProvider();

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
}
