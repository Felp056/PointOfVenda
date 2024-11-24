import 'package:flutter/material.dart';

class mobileButton extends StatelessWidget {
  mobileButton({
    super.key,
    required this.buttonName,
    required this.buttonFunction,
    required this.buttonWidth,
    required this.buttonHeight,
    this.icon,
    this.cor,
    this.iconCor,
    this.textCor,
  });

  String buttonName;
  VoidCallback buttonFunction;
  double buttonWidth;
  double buttonHeight;
  Icon? icon;
  Color? cor;
  Color? iconCor;
  Color? textCor;

  @override
  Widget build(BuildContext context) {
    cor ??= const Color.fromRGBO(236, 154, 41, 1);
    iconCor ??= Colors.white;
    textCor ??= Colors.white;
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton.icon(
        icon: icon,
        label: Text(
          buttonName,
          style: TextStyle(
            color: textCor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        onPressed: buttonFunction,
        style: ElevatedButton.styleFrom(
            iconColor: iconCor,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            backgroundColor: cor,
            textStyle:
                const TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
      ),
    );
  }
}
