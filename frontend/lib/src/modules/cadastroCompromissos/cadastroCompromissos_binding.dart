import 'package:get/get.dart';
import 'package:lembra_mais/src/data/provider/auth_provider.dart';
import 'package:lembra_mais/src/data/provider/categoria_provider.dart';
import 'package:lembra_mais/src/data/repository/cadastroCategoria_repository.dart';
import 'package:lembra_mais/src/data/repository/cadastroCompromissos_repository.dart';
import 'package:lembra_mais/src/modules/cadastroCompromissos/cadastroCompromissos_controller.dart';

class CadastrocompromissosBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CadastroCompromissosControllerController>(
        () => CadastroCompromissosControllerController());
    Get.lazyPut<CadastrocompromissosRepository>(
        () => CadastrocompromissosRepository());
    Get.lazyPut<AuthApiClient>(() => AuthApiClient());
    Get.lazyPut<CadastrocategoriaRepository>(
        () => CadastrocategoriaRepository());
    Get.lazyPut<CategoriaApiClient>(() => CategoriaApiClient());
  }
}
