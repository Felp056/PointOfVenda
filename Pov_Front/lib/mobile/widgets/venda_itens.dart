import 'package:flutter/material.dart';
import 'package:pov_web/mobile/widgets/button_mobile.dart';
import 'package:pov_web/mobile/widgets/widget_itens_venda.dart';

class VendaItens extends StatefulWidget {
  const VendaItens({
    super.key,
    required this.altura,
    required this.largura,
  });

  final double altura;
  final double largura;
  final Color bgColor = const Color.fromRGBO(218, 210, 216, 1);

  @override
  // ignore: no_logic_in_create_state
  State<VendaItens> createState() => _VendaItensState(
        altura,
        largura,
      );

  get getAltura => altura;
  get getLargura => largura;
}

class _VendaItensState extends State<VendaItens> {
  _VendaItensState(
    this.altura,
    this.largura,
  );

  final double altura;
  final double largura;
  final Color bgColor = const Color.fromRGBO(218, 210, 216, 1);
  List<Widget> itens = [];

  @override
  initState() {
    super.initState();
    itens = List.empty(
      growable: true,
    );

    itens.add(
      Padding(
        padding: EdgeInsets.only(bottom: largura * .05),
        child: const Center(
          child: Text(
            "Produtos",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

    itens.add(
      Padding(
        padding: EdgeInsets.only(bottom: largura * .05),
        child: mobileButton(
          buttonName: '',
          buttonFunction: addItem,
          buttonWidth: largura * .8,
          buttonHeight: altura * .07,
          icon: const Icon(Icons.add),
          cor: Colors.white,
          iconCor: Colors.black87,
        ),
      ),
    );
  }

  addItem() {
    setState(() {
      itens.add(
        Padding(
          // TODO: Implementar valores do Produto
          padding: EdgeInsets.only(bottom: largura * .05),
          child: Center(
            child: WidgetItensVenda(
              altura: altura,
              largura: largura,
              descricao: 'Teste',
              quantidade: 2,
              valorUnitario: 2.5,
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .6),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(
            color: Colors.black54,
          ),
        ),
        margin: EdgeInsets.only(
          bottom: altura * .025,
          left: altura * .025,
          right: altura * .025,
        ),
        padding: EdgeInsets.all(largura * .05),
        width: largura,
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: itens,
        ),
      ),
    );
  }
}
