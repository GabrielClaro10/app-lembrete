import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lembra_mais/src/data/provider/user_provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final box = GetStorage();
  String nomeUsuario = 'Carregando...';

  @override
  void initState() {
    super.initState();
    carregarNome();
  }

  void carregarNome() async {
    try {
      final user = await UserProvider().buscarUsuarioDetalhes();
      setState(() {
        nomeUsuario = user['nome'] ?? 'Usuário';
        box.write('nome', nomeUsuario); // Se quiser salvar no GetStorage
      });
    } catch (e) {
      setState(() {
        nomeUsuario = 'Erro ao carregar';
      });
    }
  }

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
              Row(
                children: [
                  const SizedBox(width: 20),
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      nomeUsuario,
                      style: const TextStyle(fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.offAllNamed('home');
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
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.toNamed('CadastroCompromissos');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 20),
                    Icon(Icons.add, color: Color(0xFF34495E)),
                    SizedBox(width: 20),
                    Text('Cadastrar Compromissos',
                        style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const Divider(),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.toNamed('lembretes');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 20),
                    Icon(Icons.file_copy, color: Color(0xFF34495E)),
                    SizedBox(width: 20),
                    Text('Compromissos', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.toNamed('perfilUsuario');
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
              GestureDetector(
                onTap: () {
                  Get.toNamed('CadastroCategoria');
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
