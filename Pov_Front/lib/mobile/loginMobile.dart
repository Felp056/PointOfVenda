import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pov_web/mobile/widgets/loginBoxMobile.dart';
import 'package:pov_web/mobile/widgets/mobileAppBar.dart';

class LoginMobile extends StatefulWidget {
  const LoginMobile({super.key});

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  final userControler = TextEditingController();
  final senhaControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MobileAppBar(),
        body: loginBoxMobile(userControler: userControler));
  }
}
