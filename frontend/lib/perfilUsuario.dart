import 'package:flutter/material.dart';

class Perfilusuario extends StatelessWidget {
  const Perfilusuario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil Usuário'),
        backgroundColor: const Color(0xfff1f4f8),
      ),
      backgroundColor: const Color(0xfff1f4f8),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Row(
                  children: <Widget>[
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                        ),
                        SizedBox(height: 12),
                        Text('Trocar foto')
                      ],
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Gabriel Claro',
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                              SizedBox(width: 12),
                              Icon(
                                Icons.edit,
                                size: 24.0,
                              ),
                            ],
                          ),
                          Text('gabrielclaro@edu.unifil.br')
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                    ),
                    const Text(
                      'Mudar tema',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    Switch(
                      value: false,
                      onChanged: (bool value) {},
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Data nascimento',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(
                        color: Color(0xffe0e3e7),
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(
                        color: Color(0xffe0e3e7),
                        width: 2.0,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        print("Ícone clicado!");
                      },
                      child: const Icon(Icons.edit),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(
                        color: Color(0xffe0e3e7),
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(
                        color: Color(0xffe0e3e7),
                        width: 2.0,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        print("Ícone clicado!");
                      },
                      child: const Icon(Icons.edit),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Telefone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(
                        color: Color(0xffe0e3e7),
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(
                        color: Color(0xffe0e3e7),
                        width: 2.0,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        print("Ícone clicado!");
                      },
                      child: const Icon(Icons.edit),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
