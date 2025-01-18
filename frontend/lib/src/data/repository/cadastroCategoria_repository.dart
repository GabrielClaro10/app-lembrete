import 'package:lembra_mais/src/data/model/cadastroCategoria_model.dart';
import 'package:lembra_mais/src/data/provider/auth_provider.dart';

class CadastrocategoriaRepository {
  final AuthApiClient apiClient = AuthApiClient();

  Future<CadastroCategoria> registerCompromissos(
    String nome,
    String status,
  ) async {
    return CadastroCategoria.fromJson(await apiClient.registerCategoria(
      nome,
      status,
    ));
  }
}
