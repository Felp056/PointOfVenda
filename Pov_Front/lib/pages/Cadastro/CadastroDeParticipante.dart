import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pov_web/widgets/dropMenu.dart';
import 'package:pov_web/DataModels/Pariticiapnte.dart';
import '../../afterLogin.dart';
import '../../widgets/CadastroForm.dart';

class CadastroParticipante extends StatefulWidget {
  CadastroParticipante({super.key, required this.title});

  final String title;

  @override
  State<CadastroParticipante> createState() => _CadastroParticipanteState();
}

class _CadastroParticipanteState extends State<CadastroParticipante> {
  List<Participante> participantes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchParticipantes();
  }

  Future<void> fetchParticipantes() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost:8080/api/participante/todas'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          participantes =
              data.map((json) => Participante.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Erro ao carregar participantes');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e); // Adicione tratamento de erro conforme necessário
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastro de Participante',
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Color(0xff8D99AE),
      drawer: DropMenu(onMenuTap: (mainMenu, subMenu) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            switch (subMenu) {
              case "Participante":
                return CadastroParticipante(title: "Cadastro de Participante");
              default:
                return afterLogin(title: "P.O.V");
            }
          }),
        );
      }),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xffEDF2F4),
                    border: Border.all(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      CadastroForm(isLargeScreen: constraints.maxWidth >= 600),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        children: participantes.map((participante) {
                          return Container(
                            margin: EdgeInsets.only(top: 16),
                            decoration: BoxDecoration(
                              color: Color(0xffEDF2F4),
                              border:
                                  Border.all(color: Colors.black, width: 2.0),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: ExpansionTile(
                                title: Text(
                                  participante.Nome,
                                  style: TextStyle(color: Colors.black),
                                ),
                                tilePadding:
                                    EdgeInsets.symmetric(horizontal: 16.0),
                                backgroundColor: Color(0xffEDF2F4),
                                collapsedBackgroundColor: Color(0xffEDF2F4),
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      "Email: ${participante.Email}\n"
                                      "Documento: ${participante.Documento}\n"
                                      "Celular: ${participante.NumContato}\n"
                                      "Endereço: ${participante.Endereco}",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
