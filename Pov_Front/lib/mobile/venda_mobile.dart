import 'package:flutter/material.dart';
import 'package:pov_web/mobile/widgets/mobileAppBar.dart';
import 'package:pov_web/mobile/widgets/widget_itens_venda.dart';

class VendaMobile extends StatefulWidget {
  const VendaMobile({
    super.key,
  });

  @override
  State<VendaMobile> createState() => _VendaMobileState();
}

class _VendaMobileState extends State<VendaMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MobileAppBar(pageTitle: "Venda"),
      body: Container(
        alignment: Alignment.center,
        child: WidgetItensVenda(),
      ),
    );
  }
}
