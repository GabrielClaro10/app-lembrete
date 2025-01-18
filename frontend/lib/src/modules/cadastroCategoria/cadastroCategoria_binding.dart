import 'package:get/get.dart';
import 'package:lembra_mais/src/data/provider/auth_provider.dart';
import 'package:lembra_mais/src/data/repository/cadastroCategoria_repository.dart';
import 'package:lembra_mais/src/modules/cadastroCategoria/cadastroCategoria_controller.dart';

class CadastrocategoriaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CadastrocategoriaController>(
        () => CadastrocategoriaController());
    Get.lazyPut<CadastrocategoriaRepository>(
        () => CadastrocategoriaRepository());
    Get.lazyPut<AuthApiClient>(() => AuthApiClient());
  }
}
