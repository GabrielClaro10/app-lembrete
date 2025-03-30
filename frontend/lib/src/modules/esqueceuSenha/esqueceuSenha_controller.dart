import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lembra_mais/src/data/repository/auth_repository.dart';

class EsqueceuSenhaController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final AuthRepository authRepository = AuthRepository();
  final formKey = GlobalKey<FormState>();

  Future<void> recuperarSenha() async {
    if (!formKey.currentState!.validate()) return;
    if (emailController.text.isEmpty) {
      print("Por favor, insira um e-mail válido");
      return;
    }

    try {
      final response = await authRepository.esqueciSenha(emailController.text);

      if (response.containsKey('message')) {
        print("Sucesso");
      } else {
        print("Erro ao tentar recuperar a senha.");
      }
    } catch (erro) {
      print("Erro ao enviar solicitação: $erro");
    }
  }
}
