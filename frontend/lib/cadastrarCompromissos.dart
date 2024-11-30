import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Cadastrarcompromissos extends StatefulWidget {
  const Cadastrarcompromissos({super.key});

  @override
  _CadastrarcompromissosState createState() => _CadastrarcompromissosState();
}

class _CadastrarcompromissosState extends State<Cadastrarcompromissos> {
  final TextEditingController _localController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _alarmeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  String _tipoCompromisso = 'Reunião';

  Future<void> _cadastrarCompromisso() async {
    Uri.parse('http://127.0.0.1:8000/api/compromissos');
    final response = await http.post(
      Uri.parse('http://192.168.200.100:8000/api/compromissos'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode({}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Compromisso cadastrado com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falha ao cadastrar compromisso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                child: DropdownButton<String>(
                  value: _tipoCompromisso,
                  onChanged: (value) {
                    setState(() {
                      _tipoCompromisso = value!;
                    });
                  },
                  items: ['Reunião', 'Almoço', 'Consulta', 'Outro']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _localController,
                  decoration: const InputDecoration(
                    labelText: 'Localização',
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
                child: TextField(
                  controller: _dataController,
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
                child: TextField(
                  controller: _alarmeController,
                  decoration: const InputDecoration(
                    labelText: 'Alarme',
                    prefixIcon: Icon(Icons.alarm),
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
                child: TextField(
                  controller: _descricaoController,
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
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _cadastrarCompromisso,
                child: const Text('Cadastrar compromisso'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
