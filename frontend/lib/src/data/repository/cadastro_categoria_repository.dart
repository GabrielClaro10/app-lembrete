import 'package:get/get.dart';
import 'package:lembra_mais/src/data/model/cadastro_categoria_model.dart';
import 'package:lembra_mais/src/data/provider/auth_provider.dart';
import 'package:lembra_mais/src/data/provider/categoria_provider.dart';

class CadastrocategoriaRepository {
  final AuthApiClient apiClient = AuthApiClient();
  final CategoriaApiClient categoriaApiClient = Get.find<CategoriaApiClient>();

  Future<CadastroCategoria> registrarCategoria(
    String nome,
    String status,
    int userId,
  ) async {
    Map<String, dynamic> response =
        await apiClient.registrarCategoria(nome, status, userId);
    return CadastroCategoria.fromJson(response);
  }

  Future<List<CadastroCategoria>> buscarCategoria() async {
    List<CadastroCategoria> list = [];
    var response = await categoriaApiClient.buscarCategoria();

    for (var e in response) {
      list.add(CadastroCategoria.fromJson(e));
    }

    return list;
  }

  Future<void> deletarCategoria(int categoriaId) async {
    await categoriaApiClient.deletarCategoria(categoriaId);
  }
}
