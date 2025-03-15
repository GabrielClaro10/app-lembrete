import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lembra_mais/src/modules/detalhesCompromissos/detalhesCompromissos_controller.dart';

class DetalhesCompromissos extends StatelessWidget {
  const DetalhesCompromissos({super.key});

  @override
  Widget build(BuildContext context) {
    final detalhesController = Get.find<DetalhesCompromissosController>();
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
      backgroundColor: const Color(0xfff1f4f8),
      body: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xfff1f4f8),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Detalhes do lembrete',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() => Text(
                    "Tipo Compromisso: ${detalhesController.categoria}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  )),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'Local: ',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    WidgetSpan(
                      child: Obx(() => Text(
                            detalhesController.local.value,
                            style: const TextStyle(
                              color: Color(0xFF757575),
                              fontSize: 14,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              RichText(
                text: TextSpan(
                  text: 'Data: ',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    WidgetSpan(
                      child: Obx(() => Text(
                            detalhesController.data.substring(0, 10),
                            style: const TextStyle(
                              color: Color(0xFF757575),
                              fontSize: 14,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              RichText(
                text: TextSpan(
                  text: 'Horas: ',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    WidgetSpan(
                      child: Obx(() => Text(
                            detalhesController.data.substring(10),
                            style: const TextStyle(
                              color: Color(0xFF757575),
                              fontSize: 14,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Observação',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Obx(() => Text(
                    detalhesController.obs.value,
                  )),
              const SizedBox(height: 12),
              const Text(
                'Descrição',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Obx(() => Text(
                    detalhesController.descricao.value,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
