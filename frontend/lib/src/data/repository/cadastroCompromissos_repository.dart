import 'package:lembra_mais/src/data/model/cadastroCompromissos_model.dart';
import 'package:lembra_mais/src/data/provider/auth_provider.dart';

class CadastrocompromissosRepository {
  final AuthApiClient apiClient = AuthApiClient();

  Future<CadastroCompromissos> registerCompromissos(
    String tipoCompromisso,
    String local,
    String data,
    bool repetirAlarme,
    String descricao,
    String notificacao,
    String? status,
    String? obs,
  ) async {
    return CadastroCompromissos.fromJson(await apiClient.registerCompromissos(
        tipoCompromisso,
        local,
        data,
        repetirAlarme,
        descricao,
        notificacao,
        status,
        obs));
  }
}
