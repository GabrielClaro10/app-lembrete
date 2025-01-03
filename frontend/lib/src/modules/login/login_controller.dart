import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lembra_mais/src/data/repository/auth_repository.dart';

import '../../data/model/auth_model.dart';

class LoginController extends GetxController {
  final repository = Get.find<AuthRepository>();
  late Auth auth;
  final formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final box = GetStorage('lembrarMais');

  RxBool showPassword = false.obs;

  void login() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      auth = await repository.login(email.text, password.text);
      if (auth.tokenType!.isNotEmpty) {
        box.write('auth', auth.toJson());
        Get.offAllNamed('/home');
      }
    }
  }
}
