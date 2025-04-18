import 'package:get/get.dart';
import 'package:lembra_mais/src/data/provider/categoria_provider.dart';
import 'package:lembra_mais/src/data/repository/cadastro_categoria_repository.dart';
import 'package:lembra_mais/src/modules/cadastroCategoria/cadastro_categoria_controller.dart';

class CadastrocategoriaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CadastrocategoriaController>(
        () => CadastrocategoriaController());
    Get.lazyPut<CadastrocategoriaRepository>(
        () => CadastrocategoriaRepository());
    Get.lazyPut<CategoriaApiClient>(() => CategoriaApiClient());
  }
}
