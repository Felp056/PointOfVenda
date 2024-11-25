import 'package:flutter/material.dart';
import 'package:pov_web/mobile/widgets/button_mobile.dart';
import 'package:pov_web/mobile/widgets/expandable_controller.dart';
import 'package:pov_web/mobile/widgets/mobileAppBar.dart';
import 'package:pov_web/mobile/widgets/venda_header.dart';
import 'package:pov_web/mobile/widgets/venda_itens.dart';

class VendaMobile extends StatefulWidget {
  VendaMobile({
    super.key,
  });

  final ExpandableController controller = ExpandableController();

  @override
  State<VendaMobile> createState() => _VendaMobileState();
}

class _VendaMobileState extends State<VendaMobile> {
  List<Widget> itensVenda = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final altura = MediaQuery.of(context).size.height;
    final largura = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: MobileAppBar(pageTitle: "Venda"),
      body: ListView(
        children: [
          Container(
            height: altura,
            width: largura,
            alignment: Alignment.center,
            child: Column(
              children: [
                VendaHeader(
                  // Onde aparecem os dados da venda, Cliente, Forma de Pagamento e Tabela de preço
                  altura: altura,
                  largura: largura,
                  controller: widget.controller,
                ),
                VendaItens(
                  // Onde aparecem os itens da Venda
                  altura: altura,
                  largura: largura,
                  controller: widget.controller,
                ),
                Container(
                  // Botão de Fechar pedido
                  margin: EdgeInsets.only(
                    bottom: altura * .025,
                    left: altura * .025,
                    right: altura * .025,
                  ),
                  child: MobileButton(
                      buttonName: "Fechar Pedido",
                      buttonFunction: fecharPedido,
                      buttonWidth: largura,
                      buttonHeight: altura * .07),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  fecharPedido() {
    Navigator.pushNamed(
      context,
      '/checkout',
    );
  }
}
