import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lembra_mais/src/modules/cadastroCategoria/cadastroCategoria.dart';
import 'package:lembra_mais/src/modules/cadastroCategoria/cadastroCategoria_binding.dart';
import 'package:lembra_mais/src/modules/cadastroCompromissos/cadastroCompromissos.dart';
import 'package:lembra_mais/src/modules/cadastroCompromissos/cadastroCompromissos_binding.dart';
import 'package:lembra_mais/src/modules/cadastroUsers/cadastroUsers_binding.dart';
import 'package:lembra_mais/src/modules/home/home.dart';
import 'package:lembra_mais/src/modules/cadastroUsers/cadastroUsers.dart';
import '../modules/login/login.dart';
import '../modules/login/login_binding.dart'; // Importe o LoginBinding

void main() async {
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final auth = box.read('auth');

    return GetMaterialApp(
      title: 'Aplicativo GB',
      initialRoute: auth != null ? '/home' : '/login', // Define a rota inicial
      debugShowCheckedModeBanner: false,
      getPages: [
        // Rota de login com o binding do LoginController
        GetPage(
          name: '/login',
          page: () => Login(),
          binding: LoginBinding(), // Associe o binding aqui
        ),
        GetPage(
          name: '/CadastrarUser',
          page: () => CadastrarUser(),
          binding: CadastrousersBinding(), // Associe o binding aqui
        ),
        GetPage(
          name: '/CadastroCompromissos',
          page: () => Cadastrocompromissos(),
          binding: CadastrocompromissosBinding(), // Associe o binding aqui
        ),
        GetPage(
          name: '/CadastroCategoria',
          page: () => CadastroCategoria(),
          binding: CadastrocategoriaBinding(), // Associe o binding aqui
        ),
        // Rota da tela de home
        GetPage(name: '/home', page: () => const Home()),
      ],
    );
  }
}
