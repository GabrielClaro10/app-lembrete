import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lembra_mais/src/modules/home/home_controller.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lembra_mais/src/modules/detalhesCompromissos/detalhesCompromissos.dart';
import 'package:lembra_mais/src/modules/lembretes/lembretes.dart';
import 'package:lembra_mais/src/modules/perfilUsuario/perfilUsuario.dart';
import 'package:lembra_mais/src/modules/cadastroSeguro/cadastroSeguro.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final HomeController controller = Get.put(HomeController());

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/CadastroCompromissos');
        },
        child: Icon(Icons.add),
        backgroundColor: const Color(0xFF34495E),
        foregroundColor: Colors.white,
      ),
      endDrawer: Drawer(
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
                const SizedBox(height: 15),
                const Divider(),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Lembretes(),
                      ),
                    );
                  },
                  child: const Row(
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Cadastroseguro(),
                      ),
                    );
                  },
                  child: const Row(
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Perfilusuario(),
                      ),
                    );
                  },
                  child: const Row(
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/CadastroCategoria');
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 20),
                      Icon(
                        Icons.person,
                        color: Color(0xFF34495E),
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Cadastrar Categoria',
                        style: TextStyle(fontSize: 14),
                      ),
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
                  controller.boxclear();
                },
                child: const Row(
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
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 160,
                  color: const Color(0xFF34495E),
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 6, top: 6),
                  child: const Text(
                    'Lembretes Recentes',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 180,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 8, top: 50),
                    children: const <Widget>[
                      Card(
                        child: SizedBox(
                          width: 200,
                          child: ListTile(
                            title: Text(
                              'Reunião',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff34495e),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Hoje 16:00'),
                                SizedBox(height: 4),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Card(
                        child: SizedBox(
                          width: 200,
                          child: ListTile(
                            title: Text(
                              'Academia',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff34495e),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text('hoje 19:00')],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Color(0xFF34495E),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                weekendTextStyle: TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Detalhescompromissos(),
                    ),
                  );
                },
                child: const ListTile(
                  title: Text(
                    'Reunião',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff34495e),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Data: 23/06/2024'),
                      SizedBox(height: 4),
                      Text('Horas: 11:00'),
                      SizedBox(height: 4),
                      Text('Local: Rua JK, 1000'),
                    ],
                  ),
                  trailing: Icon(Icons.password_outlined),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Categorias',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const <Widget>[
                ListTile(
                  title: Text(
                    'Trabalho',
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Text('9 compromissos'),
                ),
                ListTile(
                  title: Text(
                    'Pessoal',
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Text('3 compromissos'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
