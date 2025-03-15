import 'package:get/get.dart';
import 'package:lembra_mais/src/data/model/cadastroCategoria_model.dart';
import 'package:lembra_mais/src/data/model/cadastroCompromissos_model.dart';
import 'package:lembra_mais/src/data/repository/cadastroCategoria_repository.dart';
import 'package:lembra_mais/src/data/repository/cadastroCompromissos_repository.dart';

class LembretesController extends GetxController {
  final repository = Get.find<CadastrocompromissosRepository>();
  final repositoryCat = Get.find<CadastrocategoriaRepository>();
  final RxList<CadastroCategoria> listCategorias = <CadastroCategoria>[].obs;

  RxList<CadastroCompromissos> listCompromissos = <CadastroCompromissos>[].obs;

  @override
  void onInit() {
    fetchCompromissos();
    fetchCategorias();
    super.onInit();
  }

  void fetchCompromissos() async {
    try {
      var compromissos = await repository.getCompromissos();
      listCompromissos.assignAll(compromissos); // Atualiza a lista observável
    } catch (e) {
      Get.snackbar("Erro", "Falha ao buscar compromissos: $e");
    }
  }

  void fetchCategorias() async {
    try {
      var categorias = await repositoryCat.getCategoria();
      listCategorias.assignAll(categorias); // Atualiza a lista de categorias
    } catch (e) {
      Get.snackbar("Erro", "Falha ao buscar categorias: $e");
    }
  }
}
