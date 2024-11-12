import 'package:flutter/material.dart';
import 'package:pov_web/pages/Cadastro/CadastroDeParticipante.dart';
import 'package:pov_web/pages/Cadastro/CadastroDeTabelaDePreco.dart';
import 'package:pov_web/widgets/dropMenu.dart';

import 'pages/Cadastro/CadastroDeProduto.dart';

class afterLogin extends StatefulWidget {
  afterLogin({super.key, required this.title});

  final String title;

  @override
  State<afterLogin> createState() => _afterLogin();
}

class _afterLogin extends State<afterLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Point Of Venda',
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        centerTitle: false,
        backgroundColor: Colors.red,
      ),
      backgroundColor: Color(0xff8D99AE),
      drawer: DropMenu(onMenuTap: (mainMenu, subMenu) {
        Widget targetPage;
        switch (subMenu) {
          case "Participante":
            targetPage = CadastroParticipante(title: "Cadastro de Participante");
            break;
          case "Produto":
            targetPage = Cadastrodeproduto(title: "Cadastro de Produto");
          case "Tabela de Preço":
            targetPage = Cadastrodetabeladepreco(title: "Cadastro de Tabela de Preço");
            break;
          default:
            targetPage = afterLogin(title: "P.O.V");
            break;
        }
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => targetPage),
        );
      }),
    );
  }
}
