import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class loginpadrao extends StatefulWidget {
  const loginpadrao({super.key,  required this.title});
  final String title;
  @override
  State<loginpadrao> createState() => _loginpadraoState();
}
class _loginpadraoState extends State<loginpadrao> {
  @override
  final EmailControle = TextEditingController();
  final SenhaControle = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    EmailControle.dispose();
    SenhaControle.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        persistentFooterAlignment: AlignmentDirectional.center,
        body: Center(
          child: Container(
            alignment: Alignment.center,
            height: 389,
            width: 418,
            padding:const EdgeInsets.all(35.5),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color(0xFF8D99AE),
            ),
            child: Column(
              children: [
                Text(
                  "Point Of Venda",
                  style:
                  GoogleFonts.getFont('Italianno', fontSize: 54, color: Colors.white),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: EmailControle,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))
                        ),
                        hintText: 'Email:',
                        filled: true,
                        fillColor: Colors.white
                    )
                ),
                const SizedBox(height: 10),
                TextField(
                    controller: SenhaControle,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(7))),
                        hintText: 'Senha:',
                        filled: true,
                        fillColor: Colors.white
                    )
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          alignment: AlignmentDirectional.center,
                          backgroundColor: Colors.white70,
                      ),
                      onPressed: () {
                        print('button pressed!');
                      },
                      child: const Text('Novo',
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          alignment: AlignmentDirectional.center,
                          backgroundColor: Colors.green
                      ),
                      onPressed: () async {
                        final head = { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8', };
                        String url2 = "http://localhost:8080/api/usuario/login?Email="+EmailControle.text+"&Senha="+SenhaControle.text;
                        final url = Uri.parse(url2);
                        final response = await http.post(
                            url,
                            headers: head
                        );
                        if(response.statusCode == 200){
                          print("funcinou");
                        }
                      },
                      child: const Text(
                        'Entrar',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
          ,)
    );
  }
}
