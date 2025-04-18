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
    loadUserData();
  }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      foto.value = pickedFile.path;
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
                  pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Câmera'),
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void loadUserData() async {
    try {
      isLoading.value = true;

      var user = await authRepository.getUserDetails();

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
        foto.value,
        telefoneController.text,
      );

      var user = await authRepository.getUserDetails();

      nome.value = user.nome!;
      email.value = user.email!;
      foto.value = user.foto!;
      telefone.value = user.telefone!;
      dataNascimento.value = user.dataNascimento!;

      nomeController.text = user.nome!;
      telefoneController.text = user.telefone!;
      dataNascimentoController.text = user.dataNascimento!;

      Get.snackbar(
        "Sucesso",
        "Dados atualizados com sucesso!",
        colorText: Colors.white,
        backgroundColor: Colors.green[300],
        messageText: const Text(
          "Dados atualizados com sucesso!",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      );
      loadUserData();
    } catch (e) {
      print("erro $e");
    } finally {
      isLoading.value = false;
    }
  }
}
