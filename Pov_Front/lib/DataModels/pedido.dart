import 'dart:ffi';

class Pedido {
  final Long idPedido;
  final double valorPedido;
  final String formaPagamento;
  final double creditoDisponivel;

  Pedido(
    this.idPedido,
    this.valorPedido,
    this.formaPagamento,
    this.creditoDisponivel,
  );
}
