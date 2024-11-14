import 'package:flutter/material.dart';
import 'package:pov_web/Repository/UserRepository.dart';
import 'package:pov_web/mobile/widgets/loginBoxMobile.dart';
import 'package:pov_web/mobile/widgets/mobileAppBar.dart';

class LoginMobile extends StatefulWidget {
  const LoginMobile({
    super.key,
  });

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  final emailControler = TextEditingController();
  final senhaControler = TextEditingController();
  final repository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MobileAppBar(),
        body: loginBoxMobile(
          emailController: emailControler,
          senhaController: senhaControler,
          repository: repository,
        ));
  }
}