import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pov_web/DataModels/Produto.dart';
import 'package:pov_web/Repository/ProdutoRepository.dart';

class WidgetItensVenda extends StatefulWidget {
  WidgetItensVenda({
    super.key,
  });

  @override
  State<WidgetItensVenda> createState() => _WidgetItensVendaState();
}

class _WidgetItensVendaState extends State<WidgetItensVenda> {
  ProdutoRepository produtoRepository = ProdutoRepository();
  List<DropdownMenuItem<Produto>> produtos = [];
  Produto? prodSelecionado;
  dynamic result;
  double altura = 40;

  @override
  void initState() {
    super.initState();
    _getAllProdutos();
  }

  Future<void> _getAllProdutos() async {
    result = await produtoRepository.getAllProdutos();
    setState(() {
      produtos = List.generate(
        result.length,
        (index) => DropdownMenuItem(
          value: result[index],
          child: Text(result.elementAt(index).Descricao),
        ),
      );
      prodSelecionado = result[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: [
              SizedBox(
                width: 170,
                height: altura,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    items: produtos,
                    value: prodSelecionado,
                    onChanged: (value) {
                      setState(() {
                        prodSelecionado = value!;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                height: altura,
                child: TextField(
                  key: GlobalKey(),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Quantidade: ",
                  ),
                ),
              )
            ],
          ),
          Column(
            children: [
              SizedBox(
                width: 150,
                height: altura,
                child: TextField(
                  key: GlobalKey(),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Valor Un: ",
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                height: altura,
                child: TextField(
                  key: GlobalKey(),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Total: ",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
