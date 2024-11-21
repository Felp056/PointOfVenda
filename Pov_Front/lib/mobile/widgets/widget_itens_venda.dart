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
          child: Text(result.elementAt(index).Descricao),),);
      prodSelecionado = result[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 68,
      width: 300,
      child: Row(
        children: [
          Column(
            children: [
              DropdownButton(
                items: produtos, 
                value: prodSelecionado,
                onChanged: (value) {
                  setState(() {
                    prodSelecionado = value!;
                  });
                },
              ),
              Text(prodSelecionado!.QtdDisponivel.toString()),
            ],
          ),
          Column(
            children: [],
          ),
        ],)
    );
  }
}
