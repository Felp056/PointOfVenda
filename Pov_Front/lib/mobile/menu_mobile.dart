import 'package:flutter/material.dart';
import 'package:pov_web/mobile/widgets/mobileAppBar.dart';
import 'package:pov_web/mobile/widgets/button_mobile.dart';

class MenuMobile extends StatefulWidget {
  const MenuMobile({
    super.key,
  });

  @override
  State<MenuMobile> createState() => _MenuMobileState();
}

class _MenuMobileState extends State<MenuMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MobileAppBar(
        pageTitle: "Configurações",
      ),
      body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 10),
              mobileButton(
                buttonName: "Enviar Pedidos",
                buttonFunction: transmitirPedidos,
                buttonWidth: 275,
                buttonHeight: 36,
              ),
              const SizedBox(height: 10),
              mobileButton(
                buttonName: "Receber Carga",
                buttonFunction: receberCarga,
                buttonWidth: 275,
                buttonHeight: 36,
              )
            ],
          )),
    );
  }

  void transmitirPedidos() {
    print("Deu bom?");
  }

  void receberCarga() {
    print("Deu sim.");
  }
}
