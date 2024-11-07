import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CadastroForm extends StatefulWidget {
  final bool isLargeScreen;

  CadastroForm({required this.isLargeScreen});

  @override
  _CadastroFormState createState() => _CadastroFormState();
}

class _CadastroFormState extends State<CadastroForm> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController documentoController = TextEditingController();
  final TextEditingController celularController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  bool isFornecedor = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Campos de Nome e Email
          widget.isLargeScreen
              ? Row(
                  children: [
                    Expanded(child: buildTextField(nomeController, 'Nome')),
                    SizedBox(width: 16),
                    Expanded(child: buildTextField(emailController, 'Email')),
                  ],
                )
              : buildTextField(nomeController, 'Nome'),
          SizedBox(height: 16),

          // Campos de Documento e Celular
          widget.isLargeScreen
              ? Row(
                  children: [
                    Expanded(
                        child:
                            buildTextField(documentoController, 'Documento')),
                    SizedBox(width: 16),
                    Expanded(
                        child: buildTextField(celularController, 'Celular')),
                  ],
                )
              : buildTextField(documentoController, 'Documento'),
          SizedBox(height: 16),

          // Campo de Endereço
          buildTextField(enderecoController, 'Endereço'),
          SizedBox(height: 16),

          // Checkbox de Fornecedor
          Row(
            children: [
              Checkbox(
                value: isFornecedor,
                onChanged: (bool? value) {
                  setState(() {
                    isFornecedor = value ?? false;
                  });
                },
              ),
              Text('Fornecedor'),
            ],
          ),
          SizedBox(height: 16),

          // Botão Salvar com a requisição POST
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () async {
                // Configuração da URL e dos headers
                final Uri url = Uri.parse(
                    "http://localhost:8080/api/participante/adicionar");
                final Map<String, String> headers = {
                  'Content-Type': 'application/json',
                };

                // Corpo da requisição em JSON (sem o campo de crédito)
                final Map<String, dynamic> body = {
                  'Nome': nomeController.text,
                  'Documento': int.parse(documentoController.text),
                  'NumContato': int.parse(celularController.text),
                  'Email': emailController.text,
                  'Endereco': enderecoController.text,
                  'Fornecedor': isFornecedor,
                };

                try {
                  // Envio da requisição POST com o corpo codificado em JSON
                  final response = await http.post(
                    url,
                    headers: headers,
                    body: jsonEncode(body),
                  );

                  // Verificação da resposta
                  if (response.statusCode == 200) {
                    // Limpar os campos e atualizar o estado para "recarregar" a tela
                    setState(() {
                      nomeController.clear();
                      documentoController.clear();
                      celularController.clear();
                      emailController.clear();
                      enderecoController.clear();
                      isFornecedor = false;
                    });
                    _ShowSuccedMessage(context, response.body, "Sucesso");
                  } else {
                    _showDeniedMessage(context);
                  }
                } catch (e) {
                  print('Erro na requisição: $e');
                  _showDeniedMessage(context); // Mostra mensagem de erro
                }
              },
              child: Text('Salvar',
                  style: TextStyle(color: Colors.black, fontSize: 15)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffEC9A29),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Função auxiliar para exibir uma mensagem de erro
  void _showDeniedMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Erro"),
          content: Text("A requisição falhou ou os dados estão incorretos."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}

void _ShowSuccedMessage(
    BuildContext context, String Message, String TypeAlert) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(TypeAlert),
        content: Text(Message),
        actions: <Widget>[
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}