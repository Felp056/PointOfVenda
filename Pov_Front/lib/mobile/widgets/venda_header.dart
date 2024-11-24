import 'package:flutter/material.dart';
import 'package:pov_web/mobile/widgets/button_mobile.dart';

class VendaHeader extends StatefulWidget {
  const VendaHeader({
    super.key,
    required this.altura,
    required this.largura,
  });

  final double altura;
  final double largura;

  @override
  // ignore: no_logic_in_create_state
  State<VendaHeader> createState() => _VendaHeaderState(
        altura,
        largura,
      );

  get getAltura => altura;
  get getLargura => largura;
}

class _VendaHeaderState extends State<VendaHeader> {
  _VendaHeaderState(
    this.altura,
    this.largura,
  );

  final double altura;
  final double largura;
  final Color bgColor = const Color.fromRGBO(218, 210, 216, 1);
  List<Widget> header = [];

  @override
  initState() {
    super.initState();
    header = List.empty(
      growable: true,
    );

    header.add(
      Padding(
        padding: EdgeInsets.only(bottom: largura * .05),
        child: const Center(
          child: Text(
            "Dados do Pedido",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

    header.add(
      Padding(
        padding: EdgeInsets.only(bottom: largura * .05),
        child: mobileButton(
          buttonFunction: addCliente,
          buttonName: "Adicionar Cliente",
          icon: const Icon(Icons.add),
          iconCor: Colors.black87,
          cor: Colors.white,
          buttonWidth: largura * .8,
          buttonHeight: altura * .07,
          textCor: Colors.black,
        ),
      ),
    );

    header.add(
      Padding(
        padding: EdgeInsets.only(bottom: largura * .05),
        child: mobileButton(
          buttonFunction: addCliente,
          buttonName: "Forma de Pagamento",
          icon: const Icon(Icons.add),
          iconCor: Colors.black87,
          cor: Colors.white,
          buttonWidth: largura * .8,
          buttonHeight: altura * .07,
          textCor: Colors.black,
        ),
      ),
    );

    header.add(
      Padding(
        padding: EdgeInsets.only(bottom: largura * .05),
        child: mobileButton(
          buttonFunction: addCliente,
          buttonName: "Tabela de Preços",
          icon: const Icon(Icons.add),
          iconCor: Colors.black87,
          cor: Colors.white,
          buttonWidth: largura * .8,
          buttonHeight: altura * .07,
          textCor: Colors.black,
        ),
      ),
    );
  }

  addCliente() {}

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .50),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(
            color: Colors.black54,
          ),
        ),
        margin: EdgeInsets.all(altura * .025),
        padding: EdgeInsets.all(largura * .05),
        width: largura,
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: header,
        ),
      ),
    );
  }
}
