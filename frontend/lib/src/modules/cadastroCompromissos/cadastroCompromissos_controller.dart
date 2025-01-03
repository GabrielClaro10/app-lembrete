import 'package:get/get.dart';
import 'package:lembra_mais/src/data/repository/cadastroCompromissos_repository.dart';

class CadastrocompromissosControllerController extends GetxController {
  final CadastrocompromissosRepository repository;
  CadastrocompromissosControllerController(this.repository);

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}
