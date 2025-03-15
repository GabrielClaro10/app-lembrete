import 'package:get/get.dart';
import 'package:lembra_mais/src/data/repository/auth_repository.dart';
import 'package:lembra_mais/src/modules/perfilUsuario/perfilUsuario_controller.dart';

class PerfilusuarioBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<PerfilUsuarioController>(() => PerfilUsuarioController());
  }
}
