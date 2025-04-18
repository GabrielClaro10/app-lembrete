import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lembra_mais/src/global/widgets/customDrawer.dart';
import 'package:lembra_mais/src/modules/cadastroCategoria/cadastro_categoria_controller.dart';

class CadastroCategoria extends GetView<CadastrocategoriaController> {
  const CadastroCategoria({super.key});

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
          padding: const EdgeInsets.all(24.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Cadastrar Tipo de Compromisso',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    controller: controller.nome,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(
                          color: Color(0xffe0e3e7),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(
                          color: Color(0xffe0e3e7),
                          width: 2.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    controller.createCategoria();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF34495E),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Cadastrar'),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Obx(() => ListView.builder(
                        itemCount: controller.listCategorias.length,
                        itemBuilder: (context, index) {
                          final categoria = controller.listCategorias[index];
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
                              trailing: IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  controller.deleteCategoria(categoria.id!);
                                },
                              ),
                            ),
                          );
                        },
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
