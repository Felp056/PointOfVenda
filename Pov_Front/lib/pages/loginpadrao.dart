import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pov_web/afterLogin.dart';

import 'package:pov_web/pages/Cadastro/CadastroDeParticipante.dart';

class loginpadrao extends StatefulWidget {
  const loginpadrao({super.key, required this.title});

  final String title;

  
  @override
  State<loginpadrao> createState() => _LoginPadraoState();
}

class _LoginPadraoState extends State<loginpadrao> {
  final EmailControle = TextEditingController();
  final SenhaControle = TextEditingController();
  @override void dispose() {
    EmailControle.dispose();
    SenhaControle.dispose();
    super.dispose();
  }

  @override Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          alignment: Alignment.center,
          height: constraints.maxWidth >= 600 ? 389 : constraints.maxHeight * 0.45,
          width: constraints.maxWidth >= 600 ? 418 :  constraints.maxWidth * 0.75,
          padding: const EdgeInsets.all(35.5),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xFF8D99AE),),
          child: Column(
            mainAxisSize: MainAxisSize.min, children: [ Text("Point Of Venda",
            style: GoogleFonts.getFont(
              'Italianno', fontSize: 54, color: Colors.white,),),
            const SizedBox(height: 30),
            TextField(
              controller: EmailControle, decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(7)),),
              hintText: 'Email:',
              filled: true,
              fillColor: Colors.white,),),
            const SizedBox(height: 10),
            TextField(
              controller: SenhaControle, decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(7)),),
              hintText: 'Senha:',
              filled: true,
              fillColor: Colors.white,),),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:
            [ ElevatedButton(style: ElevatedButton.styleFrom(alignment:
            AlignmentDirectional.center, backgroundColor: Colors.white70,),
              onPressed: () {
                print('button pressed!');
              },
              child: const Text('Novo', style: TextStyle(
                  color: Colors.deepPurple),
              ),
            ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  alignment: AlignmentDirectional.center,
                  backgroundColor: Colors.green,
                ),
                onPressed: () async {
                  final Uri url = Uri.parse(
                      "http://localhost:8080/api/usuario/login");
                  final Map<String, String> queryParams = {
                    'Email': EmailControle.text,
                    'Senha': SenhaControle.text,
                  };
                  final Uri requestUrl = url.replace(
                      queryParameters: queryParams);
                  final Map<String, String> headers = {
                    'Content-Type': 'application/x-www-form-urlencoded',
                  };
                  // Corpo da requisição (formato x-www-form-urlencoded)
                  final Map<String, String> body = {
                    'Email': EmailControle.text,
                    'Senha': SenhaControle.text,
                  };
                  try {
                    final response = await http.post(
                      requestUrl, headers: headers, body: body,);
                    if (response.body == "true") {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                             afterLogin(title: "Principal")),);
                    } else {
                      _showDeniedMessage(context);
                    }
                  } catch (e) {
                    print('Erro na requisição: $e');
                  }
                },
                child: const Text('Entrar', style: TextStyle(
                    color: Colors.black),
                ),
              ),
            ],
            ),
          ],
          ),
        );
      },
      ),
      ),
    );
  }
}
void _showDeniedMessage(BuildContext context) {
  final snackBar = SnackBar(
    content: Text("Credenciais Inválidas"),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 5),
  );

  // Mostra o SnackBar na tela
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}