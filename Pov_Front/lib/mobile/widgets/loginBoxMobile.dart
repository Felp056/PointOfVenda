import 'package:flutter/material.dart';

class loginBoxMobile extends StatelessWidget {
  const loginBoxMobile({
    super.key,
    required this.userControler,
  });

  final TextEditingController userControler;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: 278,
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
            TextField(
                controller: userControler,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    hintText: 'Usuário:',
                    hintStyle:
                        TextStyle(color: Color.fromRGBO(188, 188, 188, 1)),
                    filled: true,
                    fillColor: Colors.white)),
            const SizedBox(height: 10),
            TextField(
                controller: userControler,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    hintText: 'Senha:',
                    hintStyle:
                        TextStyle(color: Color.fromRGBO(188, 188, 188, 1)),
                    filled: true,
                    fillColor: Colors.white)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => {print('Entrar')},
              child: Text('Entrar'),
            )
          ],
        ),
      ),
    );
  }
}
