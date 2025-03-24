import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lembra_mais/src/data/repository/auth_repository.dart';

class PerfilUsuarioController extends GetxController {
  final AuthRepository authRepository = Get.find();

  var nome = ''.obs;
  var email = ''.obs;
  var foto = ''.obs;
  var telefone = ''.obs;
  var dataNascimento = ''.obs;
  var isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController dataNascimentoController =
      TextEditingController();
  final TextEditingController telefoneController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() async {
    try {
      isLoading.value = true;

      var user = await authRepository.getUserDetails();

      print('Usuário recebido: $user');

      if (user != null) {
        nome.value = user.nome ?? '';
        email.value = user.email ?? '';
        foto.value = user.foto ?? '';
        telefone.value = user.telefone ?? '';
        dataNascimento.value = user.dataNascimento ?? '';
        nomeController.text = nome.value;
        telefoneController.text = telefone.value;
        dataNascimentoController.text = dataNascimento.value;
      }
    } catch (e) {
      print('Erro ao carregar dados do usuário: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUserData() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      var updatedUser = await authRepository.updateUser(
        nomeController.text,
        dataNascimentoController.text,
        null,
        telefoneController.text,
      );

      var user = await authRepository.getUserDetails();

      nome.value = user.nome!;
      email.value = user.email!;
      foto.value = '';
      telefone.value = user.telefone!;
      dataNascimento.value = user.dataNascimento!;

      nomeController.text = user.nome!;
      telefoneController.text = user.telefone!;
      dataNascimentoController.text = user.dataNascimento!;

      print("Sucesso! Dados atualizados com sucesso!");

      loadUserData();
    } catch (e) {
      print("Erro ao atualizar dados: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
