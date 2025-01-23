import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lembra_mais/src/data/model/cadastroCategoria_model.dart';
import 'package:lembra_mais/src/data/repository/cadastroCategoria_repository.dart';

class CadastrocategoriaController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nome = TextEditingController();
  final repository = Get.find<CadastrocategoriaRepository>();
  late CadastroCategoria cadastroCategoria;

  final box = GetStorage();

  Future<void> createCategoria() async {
    if (formKey.currentState!.validate()) {
      const String status = "ativo";

      try {
        String? authData = box.read('auth');
        if (authData != null) {
          var user = jsonDecode(authData)['user'];
          int userId = user['id'];

          cadastroCategoria =
              await repository.registerCompromissos(nome.text, status, userId);
          Get.snackbar("Sucesso", "Compromisso criado com sucesso");
        }
      } catch (e) {
        Get.snackbar("Erro", "Falha ao criar o compromisso: $e");
      }
      nome.clear();
    }
  }
}
