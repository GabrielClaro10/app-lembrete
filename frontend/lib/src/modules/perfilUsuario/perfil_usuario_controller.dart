import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
    carregarUsuario();
  }

  Future<void> escolhaImagem(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final file = File(pickedFile.path);

      try {
        String? fileName = await authRepository.uploadFoto(file);
        if (fileName != null && fileName.isNotEmpty) {
          foto.value = fileName;
        } else {
          Get.snackbar('Erro', 'Falha ao enviar a imagem');
        }
      } catch (e) {
        print('Erro no upload da imagem: $e');
        Get.snackbar('Erro', 'Falha ao enviar a imagem: $e');
      }
    }
  }

  void showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeria'),
                onTap: () {
                  escolhaImagem(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Câmera'),
                onTap: () {
                  escolhaImagem(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void carregarUsuario() async {
    try {
      isLoading.value = true;

      var user = await authRepository.buscarUsuarioDetalhes();

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

  Future<void> atualizarUsuario() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      var updatedUser = await authRepository.alterarUsuario(
        nomeController.text,
        dataNascimentoController.text,
        foto.value,
        telefoneController.text,
      );

      nome.value = updatedUser.nome ?? nome.value;
      telefone.value = updatedUser.telefone ?? telefone.value;
      dataNascimento.value = updatedUser.dataNascimento ?? dataNascimento.value;
      foto.value = updatedUser.foto ?? foto.value;

      carregarUsuario();

      Get.snackbar(
        "Sucesso",
        "Perfil do usuário atualizado:",
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
    } catch (e) {
      print("Erro no update: $e");
      Get.snackbar(
        "Erro",
        "Falha ao atualizar os dados: ${e.toString()}",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
