import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lembra_mais/src/data/model/cadastroCategoria_model.dart';
import 'package:lembra_mais/src/global/widgets/customDrawer.dart';
import 'package:lembra_mais/src/modules/lembretes/lembretes_controller.dart';

class Lembretes extends GetView<LembretesController> {
  const Lembretes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Voltar',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF34495E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.offAllNamed('/home');
          },
        ),
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
      endDrawer: CustomDrawer(),
      backgroundColor: const Color(0xFF34495E),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Lista de Lembretes',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: controller.pesquisaFiltro,
                  decoration: const InputDecoration(
                      hintText: 'Pesquise aqui',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffe0e3e7),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffe0e3e7),
                          width: 2,
                        ),
                      )),
                  onChanged: (value) {
                    controller.filtrarCompromissos();
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Filtrar por data'),
              ),
              const SizedBox(height: 10),
              // Date range picker section
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        DateTime? selectedStartDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (selectedStartDate != null) {
                          controller.dataInicio.value = selectedStartDate;
                          controller.filtrarCompromissos();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Obx(() {
                          return Text(
                            controller.dataInicio.value == null
                                ? 'Data Início'
                                : DateFormat('dd/MM/yyyy')
                                    .format(controller.dataInicio.value!),
                            style: const TextStyle(fontSize: 16),
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        DateTime? selectedEndDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (selectedEndDate != null) {
                          controller.dataFim.value = selectedEndDate;
                          controller.filtrarCompromissos();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Obx(() {
                          return Text(
                            controller.dataFim.value == null
                                ? 'Data Fim'
                                : DateFormat('dd/MM/yyyy')
                                    .format(controller.dataFim.value!),
                            style: const TextStyle(fontSize: 16),
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      controller.dataInicio.value = null;
                      controller.dataFim.value = null;
                      controller.filtrarCompromissos();
                    },
                    icon: const Icon(Icons.clear, color: Colors.red),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Mais recentes',
                  style: TextStyle(
                    color: Color(0xFF34495E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Expanded(
                child: Obx(() {
                  if (controller.listCategorias.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.listCompromissos.isEmpty) {
                    return const Center(
                        child: Text('Nenhum compromisso encontrado.',
                            style: TextStyle(
                              color: Colors.white,
                            )));
                  }

                  return ListView.builder(
                    itemCount: controller.listCompromissosFiltrados.length,
                    itemBuilder: (context, index) {
                      final compromissos =
                          controller.listCompromissosFiltrados[index];

                      final categoria = controller.listCategorias.firstWhere(
                        (categoria) => categoria.id == compromissos.idCategoria,
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
                              Text(compromissos.data!.substring(0, 10)),
                              const SizedBox(height: 4),
                              Text(compromissos.data!
                                  .substring(compromissos.data!.length - 5)),
                              const SizedBox(height: 4),
                              Text(compromissos.local ?? "Sem local"),
                            ],
                          ),
                          trailing: const Text('Reunião'),
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
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
