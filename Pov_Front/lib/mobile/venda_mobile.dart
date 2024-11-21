import 'package:flutter/material.dart';
import 'package:pov_web/mobile/widgets/button_mobile.dart';
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
  List<Widget> itensVenda = [];

  @override
  void initState() {
    itensVenda = List.empty(growable: true,);
    itensVenda.add(
      mobileButton(
        buttonName: '', 
        buttonFunction: add, 
        buttonWidth: 300, 
        buttonHeight: 50,
        icon: Icon(Icons.add),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MobileAppBar(pageTitle: "Venda"),
      body: Container(
        alignment: Alignment.center,
        child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: itensVenda,
              ),
            ),
        
      ),
    );
  }

  add() {
    setState(() {
      itensVenda.add(WidgetItensVenda());
    });
  }
}
