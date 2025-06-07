import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lembra_mais/src/data/model/cadastro_categoria_model.dart';
import 'package:lembra_mais/src/data/repository/cadastro_categoria_repository.dart';

class CadastrocategoriaController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nome = TextEditingController();

  final repository = Get.find<CadastrocategoriaRepository>();
  late CadastroCategoria cadastroCategoria;

  final box = GetStorage();

  RxList<CadastroCategoria> listCategorias = <CadastroCategoria>[].obs;

  @override
  void onInit() {
    buscarCategoria();
    super.onInit();
  }

  Future<void> criarCategoria() async {
    if (formKey.currentState!.validate()) {
      const String status = "ativo";

      try {
        var authData = box.read('auth');

        if (authData != null) {
          var decodedData =
              authData is String ? jsonDecode(authData) : authData;
          var user = decodedData['user'];

          if (user != null && user['id'] != null) {
            int userId = user['id'];

            await repository.registrarCategoria(nome.text, status, userId);

            Get.snackbar(
              "Sucesso",
              "Categoria criada com sucesso",
              colorText: Colors.white,
              backgroundColor: Colors.green[300],
              messageText: const Text(
                "Categoria criada com sucesso",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            );

            buscarCategoria();

            nome.clear();
          } else {
            Get.snackbar(
              "Erro",
              "Usuário não encontrado no auth.",
              colorText: Colors.white,
              backgroundColor: Colors.red[300],
              messageText: const Text(
                "Usuário não encontrado no auth.",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            );
          }
        } else {
          Get.snackbar(
            "Erro",
            "Usuário não autenticado.",
            colorText: Colors.white,
            backgroundColor: Colors.red[300],
            messageText: const Text(
              "Usuário não autenticado.",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          );
        }
      } catch (e) {
        Get.snackbar(
          "Erro",
          "Falha ao criar a categoria:",
          colorText: Colors.white,
          backgroundColor: Colors.red[300],
          messageText: const Text(
            "Falha ao criar a categoria:",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        );
      }
    }
  }

  void buscarCategoria() async {
    try {
      var categorias = await repository.buscarCategoria();
      listCategorias.assignAll(categorias);
    } catch (e) {
      Get.snackbar("Erro", "Falha ao buscar categorias: $e");
    }
  }

  Future<void> deletarCategoria(int categoriaId) async {
    try {
      await repository.deletarCategoria(categoriaId);
      listCategorias.removeWhere((categoria) => categoria.id == categoriaId);
      Get.snackbar(
        "Sucesso",
        "Categoria removida com sucesso",
        colorText: Colors.white,
        backgroundColor: Colors.green[300],
        messageText: const Text(
          "Categoria removida com sucesso",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      );
    } catch (e) {
      Get.snackbar(
        "Erro",
        "Falha ao remover categoria",
        colorText: Colors.white,
        backgroundColor: Colors.red[300],
        messageText: const Text(
          "Falha ao remover categoria",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      );
    }
  }
}
