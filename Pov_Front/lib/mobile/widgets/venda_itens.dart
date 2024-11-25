import 'package:flutter/material.dart';
import 'package:pov_web/mobile/widgets/button_mobile.dart';
import 'package:pov_web/mobile/widgets/expandable_controller.dart';
import 'package:pov_web/mobile/widgets/widget_itens_venda.dart';

class VendaItens extends StatefulWidget {
  const VendaItens({
    super.key,
    required this.altura,
    required this.largura,
    required this.controller,
  });

  final double altura;
  final double largura;
  final ExpandableController controller;

  @override
  State<VendaItens> createState() => _VendaItensState();
}

class _VendaItensState extends State<VendaItens> {
  _VendaItensState();

  final Color bgColor = const Color.fromRGBO(218, 210, 216, 1);
  late List<Widget> itens;

  @override
  initState() {
    super.initState();
    itens = List.empty(
      growable: true,
    );

    // Título: Produtos
    itens.add(
      Padding(
        padding: EdgeInsets.only(bottom: widget.largura * .05),
        child: const Center(
          child: Text(
            "Produtos",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

    // Botão para adicionar novo item
    itens.add(
      Padding(
        padding: EdgeInsets.only(bottom: widget.largura * .05),
        child: MobileButton(
          buttonName: '',
          buttonFunction: addItem,
          buttonWidth: widget.largura * .8,
          buttonHeight: widget.altura * .07,
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
          padding: EdgeInsets.only(bottom: widget.largura * .05),
          child: Center(
            child: WidgetItensVenda(
              altura: widget.altura,
              largura: widget.largura,
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
    return GestureDetector(
      onTap: () => widget.controller.expand("itens"),
      child: ValueListenableBuilder<String?>(
          valueListenable: widget.controller,
          builder: (context, expandedWidget, child) {
            bool isExpanded = expandedWidget == "itens";

            return AnimatedContainer(
              duration: const Duration(milliseconds: 190),
              constraints: BoxConstraints(
                maxHeight: isExpanded
                    ? MediaQuery.of(context).size.height * .6 // Expandido
                    : widget.altura * .1, // Contraído
              ),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                  color: Colors.black54,
                ),
              ),
              margin: EdgeInsets.only(
                bottom: widget.altura * .025,
                left: widget.altura * .025,
                right: widget.altura * .025,
              ),
              padding: EdgeInsets.all(widget.largura * .05),
              width: widget.largura,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sempre exibe o primeiro item (título)
                  itens.first,
                  const SizedBox(height: 8),
                  // Mostra o restante dos itens apenas se estiver expandido
                  if (isExpanded)
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children:
                            itens.sublist(1), // Exclui o primeiro item (título)
                      ),
                    ),
                ],
              ),
            );
          }),
    );
  }
}
