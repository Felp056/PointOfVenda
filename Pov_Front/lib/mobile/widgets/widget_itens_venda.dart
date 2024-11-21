import 'package:flutter/material.dart';
import 'package:pov_web/DataModels/Produto.dart';
import 'package:pov_web/Repository/ProdutoRepository.dart';

class WidgetItensVenda extends StatefulWidget {
  ProdutoRepository produtoRepository = ProdutoRepository();

  @override
  State<WidgetItensVenda> createState() => _WidgetItensVendaState();
}

class _WidgetItensVendaState extends State<WidgetItensVenda> {
  ProdutoRepository produtoRepository = ProdutoRepository();
  List<Produto> produtos = [];

  @override
  void initState() {
    super.initState();
    _getAllProdutos();
  }

  Future<void> _getAllProdutos() async {
    final result = await produtoRepository.getAllProdutos();
    setState(() {
      produtos = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.add_shopping_cart),
            title: Text(produtos.elementAt(index).idProduto.toString() +
                " - " +
                produtos.elementAt(index).Descricao),
            subtitle: Text(produtos.elementAt(index).CodBarras.toString()),
          );
        });
  }
}
