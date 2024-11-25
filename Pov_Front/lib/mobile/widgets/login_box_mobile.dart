import 'package:flutter/material.dart';
import 'package:pov_web/Repository/UserRepository.dart';
import 'package:pov_web/mobile/widgets/button_mobile.dart';

class LoginBoxMobile extends StatelessWidget {
  const LoginBoxMobile({
    super.key,
    required this.emailController,
    required this.senhaController,
    required this.repository,
  });

  final TextEditingController emailController;
  final TextEditingController senhaController;
  final UserRepository repository;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: 201,
        width: 320,
        padding: const EdgeInsets.all(35.5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border(
              top: BorderSide(width: 1.0, style: BorderStyle.solid),
              left: BorderSide(width: 1.0, style: BorderStyle.solid),
              right: BorderSide(width: 1.0, style: BorderStyle.solid),
              bottom: BorderSide(width: 1.0, style: BorderStyle.solid)),
          color: Color.fromRGBO(218, 210, 216, 1),
        ),
        child: Column(
          children: [
            SizedBox(
                width: 275,
                height: 36,
                child: TextField(
                    textAlignVertical: TextAlignVertical.bottom,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                        hintText: 'Email:',
                        hintStyle:
                            TextStyle(color: Color.fromRGBO(188, 188, 188, 1)),
                        filled: true,
                        fillColor: Colors.white))),
            const SizedBox(height: 10),
            SizedBox(
              width: 275,
              height: 36,
              child: TextField(
                  textAlignVertical: TextAlignVertical.bottom,
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  controller: senhaController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2))),
                      hintText: 'Senha:',
                      hintStyle:
                          TextStyle(color: Color.fromRGBO(188, 188, 188, 1)),
                      filled: true,
                      fillColor: Colors.white)),
            ),
            const SizedBox(height: 10),
            MobileButton(
                buttonName: "Entrar",
                buttonFunction: () =>
                    entrar(emailController.text, senhaController.text, context),
                buttonWidth: 275,
                buttonHeight: 36)
          ],
        ),
      ),
    );
  }

  entrar(
    String email,
    String senha,
    BuildContext context,
  ) async {
    try {
      emailController.text = "";
      senhaController.text = "";

      var login = await repository.doLogin(email, senha);
      if (login) {
        Navigator.pushNamed(
          context,
          '/homepage',
        );
      } else {
        _showDeniedMessage(context);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  void _showDeniedMessage(BuildContext context) {
    const snackBar = SnackBar(
      content: Text("Credenciais Inválidas"),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 5),
    );

    // Mostra o SnackBar na tela
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
