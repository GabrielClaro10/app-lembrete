import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lembra_mais/src/data/model/cadastro_categoria_model.dart';
import 'package:lembra_mais/src/data/model/cadastro_compromissos_model.dart';
import 'package:lembra_mais/src/data/repository/cadastro_categoria_repository.dart';
import 'package:lembra_mais/src/data/repository/cadastro_compromissos_repository.dart';

class HomeController extends GetxController {
  final box = GetStorage();

  void boxclear() {
    box.erase();
    Get.offAndToNamed('/login');
  }

  final RxList<CadastroCompromissos> compromissosFiltrados =
      <CadastroCompromissos>[].obs;
  final repository = Get.find<CadastrocompromissosRepository>();
  final repositoryCat = Get.find<CadastrocategoriaRepository>();
  final RxList<CadastroCategoria> listCategorias = <CadastroCategoria>[].obs;
  final RxList<CadastroCompromissos> listCompromissos =
      <CadastroCompromissos>[].obs;

  @override
  void onInit() {
    super.onInit();
    DateTime dataAtual = DateTime.now();
    buscarCategoria();
    filtrarCompromissos(dataAtual);
    buscarCompromisso();
  }

  void filtrarCompromissos([DateTime? dataSelecionada]) async {
    DateTime dataFiltro = dataSelecionada ?? DateTime.now();
    String dataFormatadaFiltro = DateFormat('dd/MM/yyyy').format(dataFiltro);

    try {
      var compromissos = await repository.buscarCompromisso();
      listCompromissos.assignAll(compromissos);

      compromissosFiltrados.assignAll(
        listCompromissos.where((compromisso) {
          try {
            if (compromisso.data == null) {
              print("Compromisso sem data: $compromisso");
              return false;
            }
            DateTime dataCompromisso =
                DateFormat('dd/MM/yyyy HH:mm').parse(compromisso.data!);
            String dataFormatadaCompromisso =
                DateFormat('dd/MM/yyyy').format(dataCompromisso);
            return dataFormatadaCompromisso == dataFormatadaFiltro;
          } catch (e) {
            print("Erro ao converter data: ${compromisso.data} -> $e");
            return false;
          }
        }).toList()
          ..sort((a, b) {
            try {
              DateTime dataA = DateFormat("dd/MM/yyyy HH:mm").parse(a.data!);
              DateTime dataB = DateFormat("dd/MM/yyyy HH:mm").parse(b.data!);
              return dataB.compareTo(dataA);
            } catch (e) {
              return 0;
            }
          }),
      );
    } catch (e) {
      print("Erro ao buscar compromissos: $e");
    }
  }

  void buscarCompromisso() async {
    try {
      var compromissos = await repository.buscarCompromisso();
      listCompromissos.assignAll(compromissos);
    } catch (e) {
      print("Erro Falha ao buscar compromissos:");
    }
  }

  void buscarCategoria() async {
    try {
      var categorias = await repositoryCat.buscarCategoria();
      listCategorias.assignAll(categorias);
    } catch (e) {
      print("Erro, Falha ao buscar categorias:");
    }
  }
}
