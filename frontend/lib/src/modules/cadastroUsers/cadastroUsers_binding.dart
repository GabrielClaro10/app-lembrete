import 'package:get/get.dart';
import 'package:lembra_mais/src/data/provider/auth_provider.dart';
import 'package:lembra_mais/src/data/repository/auth_repository.dart';
import 'package:lembra_mais/src/modules/cadastroUsers/cadastroUsers_controller.dart';

class CadastrousersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CadastrousersController>(() => CadastrousersController());
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<AuthApiClient>(() => AuthApiClient());
  }
}
