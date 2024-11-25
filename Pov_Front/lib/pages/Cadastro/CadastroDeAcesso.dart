import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../afterLogin.dart';
import '../../widgets/dropMenu.dart';
import 'CadastroDeParticipante.dart';
import 'CadastroDeProduto.dart';
import 'CadastroDeTabelaDePreco.dart';

class CadastroDeAcesso extends StatefulWidget {
  final String title;

  CadastroDeAcesso({super.key, required this.title});

  @override
  _CadastroDeAcessoState createState() => _CadastroDeAcessoState();
}

class _CadastroDeAcessoState extends State<CadastroDeAcesso> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  String nivelDeAcesso = "1 - Básico";

  late Future<List<Map<String, dynamic>>> _usuariosFuture;

  @override
  void initState() {
    super.initState();
    _usuariosFuture = _carregarUsuarios();
  }

  Future<List<Map<String, dynamic>>> _carregarUsuarios() async {
    final Uri url = Uri.parse("http://localhost:8080/api/usuario/todas");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        return data.map((user) {
          return {
            "id": user["Id"] ?? 0,
            "email": user["Email"] ?? "",
            "nivelDeAcesso": user["NivelAcesso"] ?? 0,
          };
        }).toList();
      } else {
        print("Erro ao carregar usuários: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Erro ao carregar usuários: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: Colors.red,
      ),
      drawer: DropMenu(onMenuTap: (mainMenu, subMenu) {
        Widget targetPage;
        switch (subMenu) {
          case "Participante":
            targetPage = CadastroParticipante(title: "Cadastro de Participante");
            break;
          case "Produto":
            targetPage = Cadastrodeproduto(title: "Cadastro de Produto");
            break;
          case "Tabela de Preço":
            targetPage = Cadastrodetabeladepreco(title: "Cadastro de Tabela de Preço");
            break;
          case "Acesso":
            targetPage = CadastroDeAcesso(
              title: "Cadastro de Acesso",
              key: UniqueKey(),
            );
            break;
          default:
            targetPage = afterLogin(title: "P.O.V");
            break;
        }
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => targetPage));
      }),
      backgroundColor: const Color(0xff8D99AE),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Formulário para cadastro
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'E-Mail:',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: senhaController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Senha:',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: nivelDeAcesso,
                          items: [
                            "1 - Básico",
                            "2 - Intermediário",
                            "3 - Gerencia/autônomo",
                            "4 - Supervisor",
                            "5 - Administrador",
                          ].map((nivel) {
                            return DropdownMenuItem(
                              value: nivel,
                              child: Text(nivel),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              nivelDeAcesso = value ?? "1 - Básico";
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: "Nível de Acesso:",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          print("Salvar clicado");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        ),
                        child: const Text(
                          "Salvar",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Tabela de usuários
            Expanded(
              child: Container(
                width: screenWidth * 0.90, // 90% da largura da tela
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                ),
                padding: const EdgeInsets.all(16),
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _usuariosFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text("Erro ao carregar usuários."));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("Nenhum usuário encontrado."));
                    }

                    final usuarios = snapshot.data!;
                    return DataTable(
                      headingRowHeight: 48,
                      columnSpacing: 0,
                      columns: [
                        DataColumn(
                          label: Expanded(
                            flex: 1,
                            child: Text(
                              "Id",
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            flex: 2,
                            child: Text(
                              "Email",
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            flex: 1,
                            child: Text(
                              "Nível de Acesso",
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                      rows: usuarios.map((usuario) {
                        return DataRow(cells: [
                          DataCell(Center(child: Text(usuario["id"].toString()))),
                          DataCell(Center(child: Text(usuario["email"]))),
                          DataCell(Center(child: Text(usuario["nivelDeAcesso"].toString()))),
                        ]);
                      }).toList(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
