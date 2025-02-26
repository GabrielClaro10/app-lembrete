import 'package:lembra_mais/src/data/model/cadastroCompromissos_model.dart';
import 'package:lembra_mais/src/data/provider/auth_provider.dart';

class CadastrocompromissosRepository {
  final AuthApiClient apiClient = AuthApiClient();

  Future<CadastroCompromissos> registerCompromissos(
    String local,
    String data,
    String descricao,
    String notificacao,
    String? status,
    String? obs,
    int idUsers,
    int idCategoria,
  ) async {
    Map<String, dynamic> response = await apiClient.registerCompromissos(
        local, data, descricao, notificacao, status, obs, idUsers, idCategoria);
    return CadastroCompromissos.fromJson(response);
  }
}
