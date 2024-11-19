import 'package:flutter/material.dart';

class mobileButton extends StatelessWidget {
  mobileButton({
    super.key,
    required this.buttonName,
    required this.buttonFunction,
    required this.buttonWidth,
    required this.buttonHeight,
  });

  String buttonName;
  VoidCallback buttonFunction;
  double buttonWidth;
  double buttonHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: buttonFunction,
        style: ElevatedButton.styleFrom(
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            backgroundColor: const Color.fromRGBO(236, 154, 41, 1),
            textStyle:
                const TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
        child: Text(buttonName),
      ),
    );
  }
}
