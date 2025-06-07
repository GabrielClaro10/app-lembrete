import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lembra_mais/src/data/repository/auth_repository.dart';

class EsqueceuSenhaController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final AuthRepository authRepository = AuthRepository();
  final formKey = GlobalKey<FormState>();

  Future<void> enviarRedefinirSenha(String email) async {
    try {
      final response = await authRepository.resetarSenha(email);
      Get.snackbar(
        "Sucesso",
        "Reset enviado com sucesso",
        colorText: Colors.white,
        backgroundColor: Colors.green[300],
        messageText: const Text(
          "Reset enviado com sucesso",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      );
      print('Reset enviado com sucesso: $response');
      Get.back();
    } catch (e) {
      Get.snackbar(
        "Erro",
        "Algo deu errado, tente novamente",
        colorText: Colors.white,
        backgroundColor: Colors.red[300],
        messageText: const Text(
          "Algo deu errado, tente novamente",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      );
    }
  }
}
