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

  RxList<CadastroCategoria> listCategorias = <CadastroCategoria>[].obs;

  @override
  void onInit() {
    fetchCategorias();
    super.onInit();
  }

  Future<void> createCategoria() async {
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

            cadastroCategoria =
                await repository.registerCategoria(nome.text, status, userId);

            Get.snackbar("Sucesso", "Categoria criada com sucesso");

            fetchCategorias();

            nome.clear();
          } else {
            Get.snackbar("Erro", "Usuário não encontrado no auth.");
          }
        } else {
          Get.snackbar("Erro", "Usuário não autenticado.");
        }
      } catch (e) {
        Get.snackbar("Erro", "Falha ao criar a categoria: $e");
      }
    }
  }

  void fetchCategorias() async {
    try {
      var categorias = await repository.getCategoria();
      listCategorias.assignAll(categorias); // Atualiza a lista observável
    } catch (e) {
      Get.snackbar("Erro", "Falha ao buscar categorias: $e");
    }
  }

  Future<void> deleteCategoria(int categoriaId) async {
    try {
      await repository.deleteCategoria(categoriaId);
      listCategorias.removeWhere((categoria) => categoria.id == categoriaId);
      Get.snackbar("Sucesso", "Categoria removida com sucesso");
    } catch (e) {
      Get.snackbar("Erro", "Falha ao remover categoria: $e");
    }
  }
}
