import 'package:flutter/material.dart';
import 'package:pov_web/DataModels/pedido.dart';
import 'package:pov_web/mobile/widgets/mobileAppBar.dart';

class CheckoutMobile extends StatelessWidget {
  const CheckoutMobile({
    super.key,
    this.pedido,
  });

  final Pedido? pedido;

  @override
  Widget build(BuildContext context) {
    if (pedido != null) {
      return Scaffold(
        appBar: MobileAppBar(pageTitle: "Pedido: ${pedido!.idPedido}"),
      );
    } else {
      return Scaffold(
        appBar: MobileAppBar(pageTitle: "Pedido: NULL"),
        body: const Center(
          child: Text("Não foi possível localizar o pedido..."),
        ),
      );
    }
  }
}
