import 'package:flutter/material.dart';
import 'package:pov_web/DataModels/Produto.dart';
import 'package:pov_web/DataModels/pedido.dart';
import 'package:pov_web/Repository/ProdutoRepository.dart';
import 'package:provider/provider.dart';

class WidgetItensVenda extends StatefulWidget {
  const WidgetItensVenda({
    super.key,
    required this.altura,
    required this.largura,
    required this.descricao,
    required this.quantidade,
    required this.valorUnitario,
  });

  final double altura;
  final double largura;

  final String descricao;
  final int quantidade;
  final double valorUnitario;

  @override
  State<WidgetItensVenda> createState() =>
      // ignore: no_logic_in_create_state
      _WidgetItensVendaState(
        altura: altura,
        largura: largura,
        descricao: descricao,
        quantidade: quantidade,
        valorUnitario: valorUnitario,
      );
}

class _WidgetItensVendaState extends State<WidgetItensVenda> {
  _WidgetItensVendaState({
    required this.descricao,
    required this.quantidade,
    required this.valorUnitario,
    required this.altura,
    required this.largura,
  });

  final double altura;
  final double largura;

  final String descricao;
  final int quantidade;
  final double valorUnitario;

  double? total;

  ProdutoRepository produtoRepository = ProdutoRepository();
  List<Produto> produtos = [];
  Produto? prodSelecionado;
  dynamic result;

  @override
  void initState() {
    super.initState();
    _getAllProdutos();
  }

  Future<void> _getAllProdutos() async {
    produtos = await produtoRepository.getAllProdutos();
    prodSelecionado = produtos[0];
  }

  @override
  Widget build(BuildContext context) {
    total ??= quantidade * valorUnitario;
    return Consumer<Pedido>(
      builder: (context, pedido, child) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: largura * .000,
          ),
          child: Container(
            width: largura * .8,
            height: altura * .07,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: EdgeInsets.all(
              largura * .027,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        descricao,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: altura * .003),
                      Text(
                        'Qtd: $quantidade',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'R\$ ${valorUnitario.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: altura * .001),
                    Text(
                      'Total: R\$ ${total!.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
