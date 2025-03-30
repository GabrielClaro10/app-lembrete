import 'package:get/get.dart';
import 'package:lembra_mais/src/modules/esqueceuSenha/esqueceuSenha_controller.dart';

class EsqueceusenhaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EsqueceuSenhaController>(() => EsqueceuSenhaController());
  }
}
