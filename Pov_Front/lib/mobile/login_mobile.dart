import 'package:flutter/material.dart';
import 'package:pov_web/Repository/UserRepository.dart';
import 'package:pov_web/mobile/widgets/login_box_mobile.dart';
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
        appBar: MobileAppBar(
          pageTitle: "Point of Venda",
        ),
        body: LoginBoxMobile(
          emailController: emailControler,
          senhaController: senhaControler,
          repository: repository,
        ));
  }
}
