import 'package:flutter/material.dart';

class MobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color appBarColor = Color.fromRGBO(217, 4, 39, 1);
  final pageTitle = 'Point of Venda';

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(pageTitle),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          shadows: <Shadow>[
            Shadow(
              offset: Offset(0, 4.0),
              blurRadius: 4,
              color: Color.fromRGBO(0, 0, 0, 200),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: appBarColor);
  }
}
