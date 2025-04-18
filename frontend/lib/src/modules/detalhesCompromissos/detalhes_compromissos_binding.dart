import 'package:get/get.dart';
import 'package:lembra_mais/src/modules/detalhesCompromissos/detalhes_compromissos_controller.dart';

class DetalhesCompromissosBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetalhesCompromissosController>(
        () => DetalhesCompromissosController());
  }
}
