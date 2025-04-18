import 'package:get/get.dart';
import 'package:lembra_mais/src/data/provider/categoria_provider.dart';
import 'package:lembra_mais/src/data/provider/compromissos_provider.dart';
import 'package:lembra_mais/src/data/repository/cadastro_categoria_repository.dart';
import 'package:lembra_mais/src/data/repository/cadastro_compromissos_repository.dart';
import 'package:lembra_mais/src/modules/lembretes/lembretes_controller.dart';

class LembretesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LembretesController>(() => LembretesController());
    Get.lazyPut<CadastrocompromissosRepository>(
        () => CadastrocompromissosRepository());
    Get.lazyPut<CompromissosApiClient>(() => CompromissosApiClient());
    Get.lazyPut<CadastrocategoriaRepository>(
        () => CadastrocategoriaRepository());
    Get.lazyPut<CategoriaApiClient>(() => CategoriaApiClient());
  }
}
