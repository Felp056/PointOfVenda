import 'package:flutter/material.dart';
import 'package:pov_web/mobile/widgets/mobileAppBar.dart';

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
      appBar: MobileAppBar(),
      body: Center(
        child: Container(
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
