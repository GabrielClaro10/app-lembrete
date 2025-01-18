import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lembra_mais/src/data/model/user_model.dart';
import 'package:lembra_mais/src/data/repository/auth_repository.dart';

class CadastrousersController extends GetxController {
  final repository = Get.find<AuthRepository>();
  final formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController dataNascimentoController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();
  late User user;
  final box = GetStorage();

  void register() async {
    if (formKey.currentState!.validate()) {
      user = await repository.register(
          emailController.text,
          passwordController.text,
          passwordConfirmationController.text,
          nomeController.text,
          dataNascimentoController.text,
          telefoneController.text);
      if (user != null) {
        box.write('auth', user.toJson());
        Get.offAllNamed('/home');
      }
    }
  }
}
