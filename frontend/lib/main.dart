import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lembra_mais/src/modules/cadastroCategoria/cadastro_categoria.dart';
import 'package:lembra_mais/src/modules/cadastroCategoria/cadastro_categoria_binding.dart';
import 'package:lembra_mais/src/modules/cadastroCompromissos/cadastro_compromissos.dart';
import 'package:lembra_mais/src/modules/cadastroCompromissos/cadastro_compromissos_binding.dart';
import 'package:lembra_mais/src/modules/cadastroUsers/cadastro_users_binding.dart';
import 'package:lembra_mais/src/modules/detalhesCompromissos/detalhes_compromissos.dart';
import 'package:lembra_mais/src/modules/detalhesCompromissos/detalhes_compromissos_binding.dart';
import 'package:lembra_mais/src/modules/esqueceuSenha/esqueceu_senha.dart';
import 'package:lembra_mais/src/modules/esqueceuSenha/esqueceu_senha_binding.dart';
import 'package:lembra_mais/src/modules/home/home.dart';
import 'package:lembra_mais/src/modules/cadastroUsers/cadastro_users.dart';
import 'package:lembra_mais/src/modules/home/home_binding.dart';
import 'package:lembra_mais/src/modules/lembretes/lembretes.dart';
import 'package:lembra_mais/src/modules/lembretes/lembretes_binding.dart';
import 'package:lembra_mais/src/modules/login/login.dart';
import 'package:lembra_mais/src/modules/login/login_binding.dart';
import 'package:lembra_mais/src/modules/perfilUsuario/perfil_usuario.dart';
import 'package:lembra_mais/src/modules/perfilUsuario/perfil_usuario_binding.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await GetStorage.init();
  await initializeDateFormatting(
      'pt_BR', null); // Inicializa formatação de data para português

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
      debugShowCheckedModeBanner: false,

      locale:
          const Locale('pt', 'BR'), // Define o idioma principal como português
      supportedLocales: const [
        Locale('pt', 'BR'), // Português do Brasil
        Locale('en', 'US'), // Inglês como fallback
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: auth != null ? '/home' : '/login', // Define a rota inicial
      getPages: [
        // Rota de login com o binding do LoginController
        GetPage(
          name: '/login',
          page: () => Login(),
          binding: LoginBinding(), // Associe o binding aqui
        ),
        GetPage(
          name: '/CadastrarUser',
          page: () => const CadastrarUser(),
          binding: CadastrousersBinding(), // Associe o binding aqui
        ),
        GetPage(
          name: '/CadastroCompromissos',
          page: () => const Cadastrocompromissos(),
          binding: CadastrocompromissosBinding(), // Associe o binding aqui
        ),
        GetPage(
          name: '/CadastroCategoria',
          page: () => const CadastroCategoria(),
          binding: CadastrocategoriaBinding(), // Associe o binding aqui
        ),
        GetPage(
          name: '/lembretes',
          page: () => const Lembretes(),
          binding: LembretesBinding(), // Associe o binding aqui
        ),
        GetPage(
          name: '/DetalhesCompromissos',
          page: () => const DetalhesCompromissos(),
          binding: DetalhesCompromissosBinding(), // Associe o binding aqui
        ),
        GetPage(
          name: '/home',
          page: () => const Home(),
          binding: HomeBinding(), // Associe o binding aqui
        ),
        GetPage(
          name: '/perfilUsuario',
          page: () => Perfilusuario(),
          binding: PerfilusuarioBinding(), // Associe o binding aqui
        ),
        GetPage(
          name: '/esqueceuSenha',
          page: () => const EsqueceuSenha(),
          binding: EsqueceusenhaBinding(), // Associe o binding aqui
        ),
      ],
    );
  }
}
