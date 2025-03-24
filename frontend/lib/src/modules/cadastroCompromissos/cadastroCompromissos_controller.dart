import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lembra_mais/src/data/model/cadastroCategoria_model.dart';
import 'package:lembra_mais/src/data/model/cadastroCompromissos_model.dart';
import 'package:lembra_mais/src/data/repository/cadastroCategoria_repository.dart';
import 'package:lembra_mais/src/data/repository/cadastroCompromissos_repository.dart';

class CadastroCompromissosController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final repository = Get.find<CadastrocompromissosRepository>();
  final TextEditingController localController = TextEditingController();
  final TextEditingController dataController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController obsController = TextEditingController();
  RxString notificacao = 'Todos os dias'.obs;
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

  void updatenotificacao(String not) {
    notificacao.value = not;
  }

  DateTime parseDate(String dateString) {
    // Definindo o formato da data que você está recebendo
    DateFormat format = DateFormat("dd/MM/yyyy HH:mm");

    // Convertendo a string para DateTime
    try {
      return format.parse(dateString);
    } catch (e) {
      print("Erro ao parsear a data: $e");
      return DateTime.now(); // Retorne a data atual em caso de erro
    }
  }

  /* void scheduleDailyAlarm(DateTime scheduledTime, String message) {
    NotificationService.scheduleDailyNotification(
      0, // ID do alarme
      'Lembrete diário', // Título da notificação
      message, // Mensagem da notificação
      scheduledTime, // Hora e data inicial
    );
  }

  void scheduleWeeklyAlarm(DateTime nextWeek, String message) {
    NotificationService.scheduleNotification(
      1, // ID do alarme
      'Lembrete semanal', // Título da notificação
      message, // Mensagem da notificação
      nextWeek, // Data e hora do alarme na próxima semana
    );
  }

  void scheduleMonthlyAlarm(DateTime nextMonth, String message) {
    NotificationService.scheduleNotification(
      2, // ID do alarme
      'Lembrete mensal', // Título da notificação
      message, // Mensagem da notificação
      nextMonth, // Data e hora do alarme no próximo mês
    );
  }

  void testNotification() async {
    DateTime now = DateTime.now();
    await NotificationService.scheduleNotification(
      0,
      'Teste de Notificação',
      'Essa é uma notificação de teste!',
      now.add(Duration(seconds: 10)), // Exemplo: 10 segundos após agora
    );
  } */

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
              print("Erro, Por favor, selecione uma categoria.");
              return;
            }

            // Criação do compromisso
            await repository.registerCompromissos(
              localController.text,
              dataController.text,
              descricaoController.text,
              notificacao.value,
              status,
              obsController.text,
              userId,
              idCategoriaSelecionada,
            );

            print("Sucesso, Compromisso criado com sucesso");

            Get.toNamed('/lembretes');
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
