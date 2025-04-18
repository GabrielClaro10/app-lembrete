import 'package:get/get.dart';
import 'package:lembra_mais/src/modules/cadastroSeguro/cadastro_seguro_controller.dart';

class CadastroSeguroBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CadastroSeguroController>(() => CadastroSeguroController());
  }
}
