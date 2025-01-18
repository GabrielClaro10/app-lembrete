import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lembra_mais/src/data/model/cadastroCompromissos_model.dart';
import 'package:lembra_mais/src/data/repository/cadastroCompromissos_repository.dart';

class CadastrocompromissosControllerController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final repository = Get.find<CadastrocompromissosRepository>();
  final TextEditingController localController = TextEditingController();
  final TextEditingController dataController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController obsController = TextEditingController();
  RxString tipoCompromisso = 'Reunião'.obs;
  RxString notificacao = 'Todos os dias'.obs;
  late CadastroCompromissos cadastroCompromissos;

  RxBool repetirAlarme = false.obs;

  void repetir(bool value) {
    repetirAlarme.value = value;
  }

  void updateCompromisso(String novoTipo) {
    tipoCompromisso.value = novoTipo;
  }

  void updatenotificacao(String not) {
    notificacao.value = not;
  }

  Future<void> createCompromissos() async {
    if (formKey.currentState!.validate()) {
      const String status = "ativo";

      try {
        cadastroCompromissos = await repository.registerCompromissos(
            tipoCompromisso.value,
            localController.text,
            dataController.text,
            repetirAlarme.value,
            descricaoController.text,
            notificacao.value,
            status,
            obsController.text);
        Get.snackbar("Sucesso", "Compromisso criado com sucesso");
      } catch (e) {
        Get.snackbar("Erro", "Falha ao criar o compromisso: $e");
      }
    }
  }
}
