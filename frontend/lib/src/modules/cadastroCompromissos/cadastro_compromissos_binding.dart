import 'package:get/get.dart';
import 'package:lembra_mais/src/data/provider/auth_provider.dart';
import 'package:lembra_mais/src/data/provider/categoria_provider.dart';
import 'package:lembra_mais/src/data/provider/compromissos_provider.dart';
import 'package:lembra_mais/src/data/repository/cadastro_categoria_repository.dart';
import 'package:lembra_mais/src/data/repository/cadastro_compromissos_repository.dart';
import 'package:lembra_mais/src/modules/cadastroCompromissos/cadastro_compromissos_controller.dart';

class CadastrocompromissosBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CadastroCompromissosController>(
        () => CadastroCompromissosController());
    Get.lazyPut<CadastrocompromissosRepository>(
        () => CadastrocompromissosRepository());
    Get.lazyPut<AuthApiClient>(() => AuthApiClient());
    Get.lazyPut<CadastrocategoriaRepository>(
        () => CadastrocategoriaRepository());
    Get.lazyPut<CategoriaApiClient>(() => CategoriaApiClient());
    Get.lazyPut<CompromissosApiClient>(() => CompromissosApiClient());
  }
}
