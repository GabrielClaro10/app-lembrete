import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final box = GetStorage();

  void boxclear() {
    box.erase();
    Get.offAndToNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              const Row(
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

              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),

              /// **Item 2: Senhas**
              GestureDetector(
                onTap: () {
                  Get.toNamed('home');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 20),
                    Icon(Icons.home, color: Color(0xFF34495E)),
                    SizedBox(width: 20),
                    Text('home', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),

              const SizedBox(height: 15),
              const Divider(),
              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  Get.toNamed('/lembretes');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 20),
                    Icon(Icons.file_copy, color: Color(0xFF34495E)),
                    SizedBox(width: 20),
                    Text('Lembretes', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),

              /// **Item 3: Perfil**
              GestureDetector(
                onTap: () {
                  Get.toNamed('/perfilUsuario');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 20),
                    Icon(Icons.person, color: Color(0xFF34495E)),
                    SizedBox(width: 20),
                    Text('Perfil', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),

              /// **Item 4: Cadastrar Categoria**
              GestureDetector(
                onTap: () {
                  Get.toNamed('/CadastroCategoria');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 20),
                    Icon(Icons.category, color: Color(0xFF34495E)),
                    SizedBox(width: 20),
                    Text('Cadastrar Categoria', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
            ],
          ),

          /// **Botão de Logout**
          Padding(
            padding: const EdgeInsets.all(24),
            child: GestureDetector(
              onTap: () {
                boxclear();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.exit_to_app, color: Color(0xFF34495E)),
                  SizedBox(width: 20),
                  Text('Sair', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
