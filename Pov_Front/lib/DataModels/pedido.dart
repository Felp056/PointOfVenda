import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pov_web/DataModels/Produto.dart';

class Pedido extends ChangeNotifier {
  Long? idPedido;
  double? valorPedido;
  String? formaPagamento;
  double? creditoDisponivel;

  List<Produto>? produtos;

  @override
  Pedido();

  @override
  Pedido.iniciar(
    this.idPedido,
    this.valorPedido,
    this.formaPagamento,
    this.creditoDisponivel,
    this.produtos,
  );

  addProduto(item) {
    produtos!.add(item);
  }

  salvar() {}

  Map<String, dynamic> toJson() {
    return {
      'idPedido': idPedido,
      'valorPedido': valorPedido,
      'formaPagamento': formaPagamento,
      'creditoDisponivel': creditoDisponivel,
    };
  }
}
