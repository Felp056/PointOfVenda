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
  double altura = .0;
  double largura = .0;
  @override
  Widget build(BuildContext context) {
    altura = MediaQuery.of(context).size.height;
    largura = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: MobileAppBar(
        pageTitle: "Menu",
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(
                  altura * .025,
                ),
                child: mobileButton(
                  buttonName: "Nova venda",
                  buttonFunction: novaVenda,
                  buttonWidth: largura * .8,
                  buttonHeight: altura * .07,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: altura * .025,
                  left: altura * .025,
                  right: altura * .025,
                ),
                child: mobileButton(
                  buttonName: "Transmitir Pedidos",
                  buttonFunction: transmitirPedidos,
                  buttonWidth: largura * .8,
                  buttonHeight: altura * .07,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: altura * .025,
                  left: altura * .025,
                  right: altura * .025,
                ),
                child: mobileButton(
                  buttonName: "Receber Carga",
                  buttonFunction: receberCarga,
                  buttonWidth: largura * .8,
                  buttonHeight: altura * .07,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void transmitirPedidos() {
    print("Deu bom?");
  }

  void receberCarga() {
    print("Deu sim.");
  }

  novaVenda() {
    Navigator.pushNamed(
      context,
      '/vendas',
    );
  }
}
