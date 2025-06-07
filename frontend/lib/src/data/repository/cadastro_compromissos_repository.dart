import 'package:get/get.dart';
import 'package:lembra_mais/src/data/model/cadastro_compromissos_model.dart';
import 'package:lembra_mais/src/data/provider/auth_provider.dart';
import 'package:lembra_mais/src/data/provider/compromissos_provider.dart';

class CadastrocompromissosRepository {
  final AuthApiClient apiClient = AuthApiClient();
  final CompromissosApiClient compromissosApiClient =
      Get.find<CompromissosApiClient>();

  Future<CadastroCompromissos> registrarCompromisso(
    String local,
    String data,
    String descricao,
    String? status,
    String? obs,
    int idUsers,
    int idCategoria,
  ) async {
    Map<String, dynamic> response = await apiClient.registrarCompromisso(
        local, data, descricao, status, obs, idUsers, idCategoria);

    return CadastroCompromissos.fromJson(response['data']);
  }

  Future<List<CadastroCompromissos>> buscarCompromisso() async {
    List<CadastroCompromissos> list = [];
    var response = await compromissosApiClient.buscarCompromisso();

    for (var e in response) {
      list.add(CadastroCompromissos.fromJson(e));
    }

    return list;
  }

  Future<void> deletarCompromisso(int compromissoId) async {
    await compromissosApiClient.deletarCompromisso(compromissoId);
  }
}
