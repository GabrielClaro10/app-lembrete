import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lembra_mais/src/data/model/cadastroCategoria_model.dart';
import 'package:lembra_mais/src/modules/cadastroCompromissos/cadastroCompromissos_controller.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Cadastrocompromissos extends GetView<CadastroCompromissosController> {
  Cadastrocompromissos({super.key});

  @override
  Widget build(BuildContext context) {
    var maskFormatter = MaskTextInputFormatter(mask: '##/##/#### ##:##');

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
            Navigator.pop(context);
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
      endDrawer: const Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 20),
                Row(
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
                SizedBox(height: 15),
                Divider(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 20),
                    Icon(
                      Icons.file_copy,
                      color: Color(0xFF34495E),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Lembretes',
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 20),
                    Icon(
                      Icons.password,
                      color: Color(0xFF34495E),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Senhas',
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 20),
                    Icon(
                      Icons.person,
                      color: Color(0xFF34495E),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Perfil',
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Divider(),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.exit_to_app,
                    color: Color(0xFF34495E),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Sair',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF34495E),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: const BoxDecoration(
            color: Color(0xfff1f4f8),
          ),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Cadastre seu Compromissso',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Preencha seus compromissos aqui',
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Obx(() {
                    return DropdownButton<CadastroCategoria>(
                      hint: const Text("Selecione um tipo compromisso"),
                      value: controller.categoriaSelecionada.value,
                      onChanged: (CadastroCategoria? novaCategoria) {
                        if (novaCategoria != null) {
                          controller.setCatSelecionada(novaCategoria);
                        }
                      },
                      items: controller.listCategorias
                          .map<DropdownMenuItem<CadastroCategoria>>(
                              (CadastroCategoria categoria) {
                        return DropdownMenuItem<CadastroCategoria>(
                          value: categoria,
                          child: Text(categoria.nome!),
                        );
                      }).toList(),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    controller: controller.localController,
                    decoration: const InputDecoration(
                      labelText: 'Local',
                      prefixIcon: Icon(Icons.map_outlined),
                      border: InputBorder.none,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffe0e3e7),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffe0e3e7),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    controller: controller.dataController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [maskFormatter],
                    decoration: const InputDecoration(
                      labelText: 'Selecione data',
                      prefixIcon: Icon(Icons.calendar_month),
                      border: InputBorder.none,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffe0e3e7),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffe0e3e7),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    controller: controller.descricaoController,
                    decoration: const InputDecoration(
                      labelText: 'Descrição',
                      prefixIcon: Icon(Icons.description_outlined),
                      border: InputBorder.none,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffe0e3e7),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffe0e3e7),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    controller: controller.obsController,
                    decoration: const InputDecoration(
                      labelText: 'Observação',
                      prefixIcon: Icon(Icons.description_outlined),
                      border: InputBorder.none,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffe0e3e7),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffe0e3e7),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Repetir Alarme ?',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Obx(() => Row(
                          children: [
                            const SizedBox(width: 8),
                            ChoiceChip(
                              label: Text(controller.repetirAlarme.value
                                  ? "Sim"
                                  : "Não"),
                              selected: controller.repetirAlarme.value,
                              onSelected: (bool selected) {
                                controller.repetir(selected);
                              },
                              selectedColor: Colors.blue,
                              labelStyle: TextStyle(
                                color: controller.repetirAlarme.value
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              elevation: 2,
                            ),
                          ],
                        )),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Obx(
                    () => Visibility(
                      visible: controller.repetirAlarme.value,
                      child: DropdownButton<String>(
                        value: controller.notificacao.value,
                        onChanged: (value) {
                          controller.updatenotificacao(value!);
                        },
                        items: [
                          'Todos os dias',
                          'Uma vez por semana',
                          'Uma vez no mês',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: controller.createCompromissos,
                  child: const Text('Cadastrar compromisso'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
