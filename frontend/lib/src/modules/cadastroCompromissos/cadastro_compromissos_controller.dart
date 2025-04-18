import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lembra_mais/src/data/model/cadastro_categoria_model.dart';
import 'package:lembra_mais/src/data/model/cadastro_compromissos_model.dart';
import 'package:lembra_mais/src/data/repository/cadastro_categoria_repository.dart';
import 'package:lembra_mais/src/data/repository/cadastro_compromissos_repository.dart';

class CadastroCompromissosController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final repository = Get.find<CadastrocompromissosRepository>();
  final TextEditingController localController = TextEditingController();
  final TextEditingController dataController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController obsController = TextEditingController();
  late CadastroCompromissos cadastroCompromissos;
  final repositoryCat = Get.find<CadastrocategoriaRepository>();
  final RxList<CadastroCategoria> listCategorias = <CadastroCategoria>[].obs;
  final Rx<CadastroCategoria?> categoriaSelecionada =
      Rx<CadastroCategoria?>(null);

  final box = GetStorage();

  @override
  void onInit() {
    fetchCategorias();
    super.onInit();
  }

  RxBool repetirAlarme = false.obs;

  void repetir(bool value) {
    repetirAlarme.value = value;
  }

  DateTime parseDate(String dateString) {
    DateFormat format = DateFormat("dd/MM/yyyy HH:mm");
    try {
      return format.parse(dateString);
    } catch (e) {
      print("Erro ao parsear a data: $e");
      return DateTime.now();
    }
  }

  Future<void> createCompromissos() async {
    if (formKey.currentState!.validate()) {
      const String status = "ativo";

      try {
        var authData = box.read('auth');

        if (authData != null) {
          var decodedData = authData;
          var user = decodedData['user'];

          if (user != null && user['id'] != null) {
            int userId = user['id'];

            int? idCategoriaSelecionada = categoriaSelecionada.value?.id;

            if (idCategoriaSelecionada == null) {
              Get.snackbar(
                "Erro",
                "Por favor, selecione uma categoria.",
                colorText: Colors.white,
                backgroundColor: Colors.red[300],
                messageText: const Text(
                  "Por favor, selecione uma categoria.",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              );
              return;
            }
            await repository.registerCompromissos(
              localController.text,
              dataController.text,
              descricaoController.text,
              status,
              obsController.text,
              userId,
              idCategoriaSelecionada,
            );

            localController.clear();
            dataController.clear();
            descricaoController.clear();
            obsController.clear();

            Get.snackbar(
              "Sucesso",
              "Compromisso criado com sucesso",
              colorText: Colors.white,
              backgroundColor: Colors.green[300],
              messageText: const Text(
                "Compromisso criado com sucesso",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            );

            Get.offAllNamed('lembretes');
          } else {
            print("Erro, Usuário não encontrado no auth.");
          }
        } else {
          print("Erro, Usuário não autenticado.");
        }
      } catch (e) {
        print("Erro ao criar o compromisso: ${e.toString()}");
      }
    }
  }

  void fetchCategorias() async {
    var categorias = await repositoryCat.getCategoria();
    listCategorias.assignAll(categorias);
  }

  void setCatSelecionada(CadastroCategoria value) {
    categoriaSelecionada.value = value;
  }
}
