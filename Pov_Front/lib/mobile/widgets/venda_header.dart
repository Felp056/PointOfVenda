import 'package:flutter/material.dart';

class VendaHeader extends StatelessWidget {
  const VendaHeader({
    super.key,
    required this.altura,
    required this.largura,
  });

  final double altura;
  final double largura;
  final Color bgColor = const Color.fromRGBO(218, 210, 216, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(altura * .025),
      padding: EdgeInsets.all(largura * .05),
      height: altura * 0.1,
      width: largura,
      color: bgColor,
      child: ColoredBox(
        color: Colors.greenAccent,
        child: SizedBox(
          height: altura * .1,
        ),
      ),
    );
  }
}
