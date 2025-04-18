import 'package:get/get.dart';
import 'package:lembra_mais/src/data/provider/categoria_provider.dart';
import 'package:lembra_mais/src/data/provider/compromissos_provider.dart';
import 'package:lembra_mais/src/data/repository/cadastro_categoria_repository.dart';
import 'package:lembra_mais/src/data/repository/cadastro_compromissos_repository.dart';
import 'package:lembra_mais/src/modules/home/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CadastrocompromissosRepository>(
        () => CadastrocompromissosRepository());
    Get.lazyPut<CompromissosApiClient>(() => CompromissosApiClient());
    Get.lazyPut<CadastrocategoriaRepository>(
        () => CadastrocategoriaRepository());
    Get.lazyPut<CategoriaApiClient>(() => CategoriaApiClient());
  }
}
