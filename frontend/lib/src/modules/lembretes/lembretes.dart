import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lembra_mais/src/data/model/cadastroCategoria_model.dart';
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
            Navigator.pop(context);
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
      endDrawer: const Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 20),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                    ),
                    SizedBox(width: 20),
                    Text('Gabriel Claro', style: TextStyle(fontSize: 20)),
                  ],
                ),
                SizedBox(height: 15),
                Divider(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 20),
                    Icon(
                      Icons.file_copy,
                      color: Color(0xFF34495E),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Lembretes',
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 20),
                    Icon(
                      Icons.password,
                      color: Color(0xFF34495E),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Senhas',
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 20),
                    Icon(
                      Icons.person,
                      color: Color(0xFF34495E),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Perfil',
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Divider(),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.exit_to_app,
                    color: Color(0xFF34495E),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Sair',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: TextField(
                  decoration: InputDecoration(
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
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text('Filtrar por data'),
                  SizedBox(width: 20),
                  Icon(Icons.calendar_month, color: Color(0xFF34495E)),
                  SizedBox(width: 20),
                  Icon(Icons.calendar_month, color: Color(0xFF34495E)),
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

                  return ListView.builder(
                    itemCount: controller.listCompromissos.length,
                    itemBuilder: (context, index) {
                      final compromissos = controller.listCompromissos[index];

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
