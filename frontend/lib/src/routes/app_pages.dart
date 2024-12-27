import 'package:get/get.dart';
import 'package:lembra_mais/src/modules/login/login.dart';
import 'package:lembra_mais/src/modules/login/login_binding.dart';
import 'package:lembra_mais/src/routes/app_routes.dart';

class AppPages {
  static const LOGIN = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => Login(),
      binding: LoginBinding(),
    ),
  ];
}
