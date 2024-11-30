import 'package:flutter/material.dart';
import 'login.dart'; // Certifique-se de que login.dart está no mesmo diretório ou ajuste o caminho.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicativo GB', // Adicione um título para o aplicativo
      home: Login(), // Defina a página de login como home
    );
  }
}
