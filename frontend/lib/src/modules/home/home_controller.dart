import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lembra_mais/src/data/model/cadastroCategoria_model.dart';
import 'package:lembra_mais/src/data/model/cadastroCompromissos_model.dart';
import 'package:lembra_mais/src/data/repository/cadastroCategoria_repository.dart';
import 'package:lembra_mais/src/data/repository/cadastroCompromissos_repository.dart';

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
    filtrarCompromissos(dataAtual);
    fetchCompromissos();
    fetchCategorias();
  }

  void filtrarCompromissos([DateTime? dataSelecionada]) async {
    DateTime dataFiltro = dataSelecionada ?? DateTime.now();
    String dataFormatadaFiltro = DateFormat('dd/MM/yyyy').format(dataFiltro);

    try {
      var compromissos = await repository.getCompromissos();
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
        }).toList(),
      );
    } catch (e) {
      print("Erro ao buscar compromissos: $e");
    }
  }

  void fetchCompromissos() async {
    try {
      var compromissos = await repository.getCompromissos();
      listCompromissos.assignAll(compromissos); // Atualiza a lista observável
    } catch (e) {
      print("Erro Falha ao buscar compromissos:");
    }
  }

  void fetchCategorias() async {
    try {
      var categorias = await repositoryCat.getCategoria();
      listCategorias.assignAll(categorias); // Atualiza a lista de categorias
    } catch (e) {
      print("Erro, Falha ao buscar categorias:");
    }
  }
}
