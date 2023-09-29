import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class Usuario {
  final int id;
  final String nome;
  final String telefone;
  final String email;
  final DateTime dataNascimento;
  final String fotoUrl;

  Usuario({
    required this.id,
    required this.nome,
    required this.telefone,
    required this.email,
    required this.dataNascimento,
    required this.fotoUrl,
  });
}

class Usuarios extends StatefulWidget {
  const Usuarios({Key? key});

  @override
  State<Usuarios> createState() => UsuariosState();
}

class UsuariosState extends State<Usuarios> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dataNascimentoController =
      TextEditingController();

  List<Usuario> listaUsuarios = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Usuários")),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextFormField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: "Nome",
                icon: Icon(Icons.person),
              ),
            ),
            TextFormField(
              controller: telefoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Telefone",
                icon: Icon(Icons.phone),
              ),
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "E-mail",
                icon: Icon(Icons.email),
              ),
            ),
            TextFormField(
              controller: dataNascimentoController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Data de Nascimento",
                icon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  String dataFormatada =
                      DateFormat('dd/MM/yyyy').format(pickedDate);
                  setState(() {
                    dataNascimentoController.text = dataFormatada;
                  });
                }
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                int id = Random().nextInt(69) + 1;
                Usuario novoUsuario = Usuario(
                  id: id,
                  nome: nomeController.text,
                  telefone: telefoneController.text,
                  email: emailController.text,
                  dataNascimento: DateFormat('dd/MM/yyyy')
                      .parse(dataNascimentoController.text),
                  fotoUrl:
                      "https://i.pravatar.cc/300?img=" + id.toString(), 
                );
                setState(() {
                  listaUsuarios.add(novoUsuario);
                });

                nomeController.clear();
                telefoneController.clear();
                emailController.clear();
                dataNascimentoController.clear();
              },
              child: const Text("Adicionar Usuário"),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: listaUsuarios.length,
                itemBuilder: (context, index) {
                  Usuario usuario = listaUsuarios[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(usuario.fotoUrl),
                      radius: 15.0,
                    ),
                    title: Text(usuario.nome),
                    subtitle: Text(usuario.email),
                    onTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}