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

  // Função que carrega os dados do usuário usando getUserDetails
  void loadUserData() async {
    try {
      isLoading.value = true;

      // Chama o repositório para obter os dados do usuário
      var user =
          await authRepository.getUserDetails(); // Pega os detalhes do usuário

      print(user.id);

      if (user != null) {
        // Atualiza as variáveis com os dados do usuário
        nome.value = user.nome ?? '';
        email.value = user.email ?? '';
        foto.value = user.foto ?? '';
        telefone.value = user.telefone ?? '';
        dataNascimento.value = user.dataNascimento ?? '';

        // Preenche os controllers com os dados carregados
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

  // Função para atualizar os dados do usuário
  Future<void> updateUserData() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      // Chama o repositório para atualizar os dados do usuário
      var updatedUser = await authRepository.updateUser(
        nomeController.text,
        dataNascimentoController.text,
        null, // Passando null para foto, pois você quer que a imagem seja deixada vazia
        telefoneController.text,
      );

      // Agora, buscamos os dados atualizados diretamente do getUserDetails
      var user = await authRepository.getUserDetails();

      print(user);
      // Atualiza os valores nas variáveis que controlam a interface
      nome.value = user.nome!;
      email.value = user.email!;
      foto.value = ''; // Deixa a foto vazia
      telefone.value = user.telefone!;
      dataNascimento.value = user.dataNascimento!;

      // Atualiza os campos do formulário
      nomeController.text = user.nome!;
      telefoneController.text = user.telefone!;
      dataNascimentoController.text = user.dataNascimento!;

      print("Sucesso! Dados atualizados com sucesso!");

      // Chama loadUserData novamente para garantir que as informações mais recentes sejam carregadas
      loadUserData();
    } catch (e) {
      print("Erro ao atualizar dados: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
