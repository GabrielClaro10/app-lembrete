import 'package:get/get.dart';
import 'package:lembra_mais/src/data/model/cadastroCategoria_model.dart';
import 'package:lembra_mais/src/data/provider/auth_provider.dart';
import 'package:lembra_mais/src/data/provider/categoria_provider.dart';

class CadastrocategoriaRepository {
  final AuthApiClient apiClient = AuthApiClient();
  final CategoriaApiClient categoriaApiClient = Get.find<CategoriaApiClient>();

  Future<CadastroCategoria> registerCategoria(
    String nome,
    String status,
    int userId,
  ) async {
    Map<String, dynamic> response =
        await apiClient.registerCategoria(nome, status, userId);
    return CadastroCategoria.fromJson(
        response); // Convertemos o mapa de resposta para um objeto CadastroCategoria
  }

  Future<List<CadastroCategoria>> getCategoria() async {
    List<CadastroCategoria> list = [];
    var response = await categoriaApiClient.getCategoria();

    for (var e in response) {
      list.add(CadastroCategoria.fromJson(e));
    }

    return list;
  }

  Future<void> deleteCategoria(int categoriaId) async {
    await categoriaApiClient.deleteCategoria(categoriaId);
  }
}
