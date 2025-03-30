import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lembra_mais/src/data/model/cadastroCategoria_model.dart';
import 'package:lembra_mais/src/data/model/cadastroCompromissos_model.dart';
import 'package:lembra_mais/src/data/repository/cadastroCategoria_repository.dart';
import 'package:lembra_mais/src/data/repository/cadastroCompromissos_repository.dart';

class LembretesController extends GetxController {
  final repository = Get.find<CadastrocompromissosRepository>();
  final repositoryCat = Get.find<CadastrocategoriaRepository>();
  final RxList<CadastroCategoria> listCategorias = <CadastroCategoria>[].obs;
  final TextEditingController pesquisaFiltro = TextEditingController();
  var listCompromissos = <CadastroCompromissos>[].obs;
  var listCompromissosFiltrados = <CadastroCompromissos>[].obs;
  var listCategorias2 = <CadastroCategoria>[].obs;
  final Rx<DateTime?> dataInicio = Rx<DateTime?>(null);
  final Rx<DateTime?> dataFim = Rx<DateTime?>(null);

  @override
  void onInit() {
    fetchCompromissos();
    fetchCategorias();
    super.onInit();
  }

  void fetchCompromissos() async {
    try {
      var compromissos = await repository.getCompromissos();
      listCompromissos.assignAll(compromissos);
      filtrarCompromissos();
    } catch (e) {
      Get.snackbar("Erro", "Falha ao buscar compromissos: $e");
    }
  }

  void filtrarCompromissos() {
    String filtro = pesquisaFiltro.text.toLowerCase();
    List<CadastroCompromissos> compromissosFiltrados =
        List.from(listCompromissos);

    if (filtro.isNotEmpty) {
      compromissosFiltrados = compromissosFiltrados.where((compromisso) {
        var categoria = listCategorias.firstWhere(
          (cat) => cat.id == compromisso.idCategoria,
          orElse: () => CadastroCategoria(id: 0, nome: 'Desconhecido'),
        );
        return categoria.nome!.toLowerCase().contains(filtro);
      }).toList();
    }

    if (dataInicio.value != null && dataFim.value != null) {
      DateTime startDate = DateTime(dataInicio.value!.year,
          dataInicio.value!.month, dataInicio.value!.day);
      DateTime endDate = DateTime(dataFim.value!.year, dataFim.value!.month,
          dataFim.value!.day, 23, 59, 59);

      compromissosFiltrados = compromissosFiltrados.where((compromisso) {
        try {
          DateTime compromissoDate =
              DateFormat("dd/MM/yyyy HH:mm").parse(compromisso.data!);
          DateTime compromissoDateOnly = DateTime(
              compromissoDate.year, compromissoDate.month, compromissoDate.day);
          return compromissoDateOnly.isAtSameMomentAs(startDate) ||
              (compromissoDateOnly.isAfter(startDate) &&
                  compromissoDateOnly.isBefore(endDate));
        } catch (e) {
          return false;
        }
      }).toList();
    }
    listCompromissosFiltrados.assignAll(compromissosFiltrados);
  }

  void fetchCategorias() async {
    try {
      var categorias = await repositoryCat.getCategoria();
      listCategorias.assignAll(categorias);
    } catch (e) {
      Get.snackbar("Erro", "Falha ao buscar categorias: $e");
    }
  }

  void selecionarDataInicio(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: dataInicio.value ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      dataInicio.value = selectedDate;
      filtrarCompromissos();
    }
  }

  void selecionarDataFim(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: dataFim.value ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      print("📅 Data de fim selecionada: $selectedDate");
      dataFim.value = selectedDate;
      filtrarCompromissos();
    }
  }
}
