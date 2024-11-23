import 'package:flutter/material.dart';
import 'package:pov_web/DataModels/pedido.dart';
import 'package:pov_web/mobile/widgets/mobileAppBar.dart';

class CheckoutMobile extends StatelessWidget {
  const CheckoutMobile({
    super.key,
    required this.pedido,
  });

  final Pedido pedido;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MobileAppBar(pageTitle: "Pedido: ${pedido.idPedido}"),
    );
  }
}
