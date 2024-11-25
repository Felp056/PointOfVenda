import 'package:flutter/material.dart';
import 'package:pov_web/DataModels/cliente_model.dart';
import 'package:pov_web/mobile/widgets/button_mobile.dart';
import 'package:pov_web/mobile/widgets/expandable_controller.dart';
import 'package:pov_web/mobile/widgets/select_cliente_dialog.dart';
import 'package:pov_web/mobile/widgets/widget_cliente.dart';

class VendaHeader extends StatefulWidget {
  const VendaHeader({
    super.key,
    required this.altura,
    required this.largura,
    required this.controller,
  });

  final double altura;
  final double largura;
  final ExpandableController controller;

  @override
  State<VendaHeader> createState() => _VendaHeaderState();
}

class _VendaHeaderState extends State<VendaHeader> {
  _VendaHeaderState();

  final Color bgColor = const Color.fromRGBO(218, 210, 216, 1);
  late List<Widget> header;

  @override
  initState() {
    super.initState();
    header = List.empty(
      growable: true,
    );

    // Título: Dados do Pedido
    header.add(
      Padding(
        padding: EdgeInsets.only(bottom: widget.largura * .05),
        child: const Center(
          child: Text(
            "Dados do Pedido",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

    // Botão: Adicionar Cliente
    header.add(
      Padding(
        padding: EdgeInsets.only(bottom: widget.largura * .05),
        child: MobileButton(
          buttonFunction: addCliente,
          buttonName: "Adicionar Cliente",
          icon: const Icon(Icons.add),
          iconCor: Colors.black87,
          cor: Colors.white,
          buttonWidth: widget.largura * .8,
          buttonHeight: widget.altura * .07,
          textCor: Colors.black,
        ),
      ),
    );

    // Botão: Adicionar Forma de Pagamento
    header.add(
      Padding(
        padding: EdgeInsets.only(bottom: widget.largura * .05),
        child: MobileButton(
          buttonFunction: addFormaPagto,
          buttonName: "Forma de Pagamento",
          icon: const Icon(Icons.add),
          iconCor: Colors.black87,
          cor: Colors.white,
          buttonWidth: widget.largura * .8,
          buttonHeight: widget.altura * .07,
          textCor: Colors.black,
        ),
      ),
    );

    // Botão: Adicionar Tabela de Preços
    header.add(
      Padding(
        padding: EdgeInsets.only(bottom: widget.largura * .05),
        child: MobileButton(
          buttonFunction: addTabPreco,
          buttonName: "Tabela de Preços",
          icon: const Icon(Icons.add),
          iconCor: Colors.black87,
          cor: Colors.white,
          buttonWidth: widget.largura * .8,
          buttonHeight: widget.altura * .07,
          textCor: Colors.black,
        ),
      ),
    );
  }

  addCliente() {
    Cliente cliente = Cliente(
      idCliente: 1,
      nome: 'nome',
      documento: '12345678910',
      endereco: 'Rua Acolá',
    );

    showDialog(
        context: context,
        builder: (context) => SelectCliente(
              cliente: cliente,
            ));

    int index = 1;
    setState(() {
      header.removeAt(index);
      header.insert(
        index,
        Padding(
          padding: EdgeInsets.only(bottom: widget.largura * .05),
          child: WidgetCliente(
            altura: widget.altura,
            largura: widget.largura,
            cliente: cliente,
          ),
        ),
      );
    });
  }

  addFormaPagto() {}

  addTabPreco() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => widget.controller.expand("header"),
        child: ValueListenableBuilder<String?>(
            valueListenable: widget.controller,
            builder: (context, expandedWidget, child) {
              bool isExpanded = expandedWidget == "header";

              return AnimatedContainer(
                duration: const Duration(milliseconds: 190),
                constraints: BoxConstraints(
                  maxHeight: isExpanded
                      ? MediaQuery.of(context).size.height * .35 // Expandido
                      : widget.altura * .1, // Contraído
                ),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                    color: Colors.black54,
                  ),
                ),
                margin: EdgeInsets.all(widget.altura * .025),
                padding: EdgeInsets.all(widget.largura * .05),
                width: widget.largura,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sempre exibe o titulo
                    header.first,

                    // Exibe somente se expandido
                    if (isExpanded)
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: header.sublist(1), // Exclui o título
                        ),
                      ),
                  ],
                ),
              );
            }));
  }
}
