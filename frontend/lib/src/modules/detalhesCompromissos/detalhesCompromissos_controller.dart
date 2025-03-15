import 'package:get/get.dart';

class DetalhesCompromissosController extends GetxController {
  var id = 0.obs;
  var categoria = "".obs;
  var data = "".obs;
  var local = "".obs;
  var descricao = "".obs;
  var obs = "".obs;

  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      id.value = Get.arguments['id'];
      categoria.value = Get.arguments['categoria'];
      data.value = Get.arguments['data'];
      local.value = Get.arguments['local'];
      descricao.value = Get.arguments['descricao'];
      obs.value = Get.arguments['obs'];
    }
  }
}
