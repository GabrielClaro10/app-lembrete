import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lembra_mais/src/data/model/auth_model.dart';
import 'package:lembra_mais/src/data/model/user_model.dart';
import 'package:lembra_mais/src/data/repository/auth_repository.dart';

class CadastroUsersController extends GetxController {
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

  // Função de registro
  void register() async {
    if (formKey.currentState!.validate()) {
      try {
        // Não precisa mais do GetStorage.init() se já foi inicializado no início do app

        // Renomeei para authResponse para ficar mais claro que é o objeto Auth
        final Auth authResponse = await repository.register(
          emailController.text,
          passwordController.text,
          passwordConfirmationController.text,
          nomeController.text,
          dataNascimentoController.text,
          telefoneController.text,
        );

        // Verifica diretamente o token da resposta
        if (authResponse.accessToken != null) {
          Get.offAllNamed('/home');
        } else {
          throw Exception('Token não retornado pela API');
        }
      } catch (erro) {
        print('Erro no registro: $erro');
      }
    }
  }
}
