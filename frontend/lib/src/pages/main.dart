import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lembra_mais/src/modules/home/home.dart';
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
    final box = GetStorage('lembrarMais');
    final auth = box.read('auth');

    return GetMaterialApp(
      title: 'Aplicativo GB',
      initialBinding:
          LoginBinding(), // Registra as dependências ao iniciar o app
      initialRoute: auth != null ? '/home' : '/login',
      home: Login(), // Defina a página de login como home
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/home', page: () => const Home()),
      ],
    );
  }
}
