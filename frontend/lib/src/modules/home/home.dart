import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lembra_mais/src/data/model/cadastroCategoria_model.dart';
import 'package:lembra_mais/src/global/widgets/customDrawer.dart';
import 'package:lembra_mais/src/modules/home/home_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF34495E),
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/CadastroCompromissos');
        },
        child: Icon(Icons.add),
        backgroundColor: const Color(0xFF34495E),
        foregroundColor: Colors.white,
      ),
      endDrawer: CustomDrawer(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Stack(children: [
              Container(
                width: double.infinity,
                height: 160,
                color: const Color(0xFF34495E),
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 6, top: 6),
                child: const Text(
                  'Lembretes Recentes',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 180,
                child: Obx(() {
                  if (controller.listCompromissos.isEmpty) {
                    return const Center(
                      child: Text(
                        'Nenhum compromisso encontrado.',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.listCompromissos.length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 8, top: 50),
                    itemBuilder: (context, index) {
                      final compromissos = controller.listCompromissos[index];
                      final categoria = controller.listCategorias.firstWhere(
                        (categoria) => categoria.id == compromissos.idCategoria,
                        orElse: () => CadastroCategoria(
                          id: 0,
                          nome: 'Categoria não encontrada',
                        ),
                      );

                      return Card(
                        child: SizedBox(
                          width: 200,
                          child: ListTile(
                            title: Text(
                              categoria.nome ?? "Sem nome",
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color(0xff34495e),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(compromissos.data ?? "Sem data"),
                                const SizedBox(height: 4),
                                Text(compromissos.local ?? "Sem local"),
                              ],
                            ),
                            onTap: () {
                              Get.toNamed('/DetalhesCompromissos', arguments: {
                                "id": compromissos.id,
                                "categoria": categoria.nome,
                                "data": compromissos.data,
                                "local": compromissos.local,
                                "descricao": compromissos.descricao,
                                "obs": compromissos.obs,
                              });
                            },
                          ),
                        ),
                      );
                    },
                  );
                }),
              )
            ]),
            const SizedBox(height: 20),
            TableCalendar(
              locale: 'pt_BR',
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                controller.filtrarCompromissos(selectedDay);
              },
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Color(0xFF34495E),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                weekendTextStyle: TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.compromissosFiltrados.isEmpty) {
                return const Center(
                    child: Text('Nenhum compromisso para este dia'));
              }

              return ListView.builder(
                shrinkWrap: true,
                physics:
                    NeverScrollableScrollPhysics(), // Evita conflito de scroll
                itemCount: controller.compromissosFiltrados.length,
                itemBuilder: (context, index) {
                  final compromisso = controller.compromissosFiltrados[index];
                  final categoria = controller.listCategorias.firstWhere(
                    (categoria) => categoria.id == compromisso.idCategoria,
                    orElse: () => CadastroCategoria(
                        id: 0, nome: 'Categoria não encontrada'),
                  );

                  return Card(
                    child: ListTile(
                      title: Text(
                        categoria.nome ?? "Sem nome",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color(0xff34495e),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(compromisso.data
                              .toString()), // Ajuste conforme necessário
                          SizedBox(height: 4),
                          Text(compromisso.local ?? "Sem local"),
                        ],
                      ),
                      onTap: () {
                        Get.toNamed('/DetalhesCompromissos', arguments: {
                          "id": compromisso.id,
                          "categoria": categoria.nome,
                          "data": compromisso.data,
                          "local": compromisso.local,
                          "descricao": compromisso.descricao,
                          "obs": compromisso.obs,
                        });
                      },
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
