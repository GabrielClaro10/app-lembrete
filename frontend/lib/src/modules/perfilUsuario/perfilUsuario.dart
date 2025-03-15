import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lembra_mais/src/modules/perfilUsuario/perfilUsuario_controller.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Perfilusuario extends StatelessWidget {
  Perfilusuario({super.key});

  final PerfilUsuarioController controller =
      Get.find<PerfilUsuarioController>();

  @override
  Widget build(BuildContext context) {
    var maskFormatter = MaskTextInputFormatter(mask: '##/##/####');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil Usuário'),
        backgroundColor: const Color(0xfff1f4f8),
      ),
      backgroundColor: const Color(0xfff1f4f8),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Obx(() {
                    return Row(
                      children: <Widget>[
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                controller.foto.value.isEmpty
                                    ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'
                                    : controller.foto.value,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text('Trocar foto'),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.nome.value.isEmpty
                                    ? 'Nome não definido'
                                    : controller.nome.value,
                                style: const TextStyle(fontSize: 24),
                              ),
                              Text(
                                controller.email.value.isEmpty
                                    ? 'Email não definido'
                                    : controller.email.value,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(left: 16),
                      ),
                      const Text(
                        'Mudar tema',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Switch(
                        value: false,
                        onChanged: (bool value) {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: controller.nomeController,
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
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    inputFormatters: [maskFormatter],
                    controller: controller.dataNascimentoController,
                    decoration: InputDecoration(
                      labelText: 'Data nascimento',
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
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller.telefoneController,
                    decoration: InputDecoration(
                      labelText: 'Telefone',
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
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      controller.updateUserData();
                    },
                    child: Text('Editar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF34495E),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
