import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Dataform extends StatefulWidget {
  final bool isLargeScreen;
  final String Nomedata;
  final String Emaildata;
  final int Documentodata;
  final String Enderecodata;
  final int Celuladata;
  final bool Fornecedor;
  final int id;

  Dataform({
    required this.isLargeScreen,
    required this.Nomedata,
    required this.Emaildata,
    required this.Documentodata,
    required this.Enderecodata,
    required this.Celuladata,
    required this.Fornecedor,
    required this.id


  });

  @override
  _DataformState createState() => _DataformState();
}

class _DataformState extends State<Dataform> {
  late TextEditingController nomeController;
  late TextEditingController documentoController;
  late TextEditingController celularController;
  late TextEditingController emailController;
  late TextEditingController enderecoController;
  bool isFornecedor = false;
  late int id;

  @override
  void initState() {
    super.initState();

    // Inicializando os controladores com os valores do construtor
    nomeController = TextEditingController(text: widget.Nomedata);
    emailController = TextEditingController(text: widget.Emaildata);
    documentoController = TextEditingController(text: widget.Documentodata.toString());
    celularController = TextEditingController(text: widget.Celuladata.toString());
    enderecoController = TextEditingController(text: widget.Enderecodata);
    isFornecedor = widget.Fornecedor;
    id = widget.id;
  }

  @override
  void dispose() {
    // Liberando memória ao descartar controladores
    nomeController.dispose();
    emailController.dispose();
    documentoController.dispose();
    celularController.dispose();
    enderecoController.dispose();
    super.dispose();
  }

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
                  child: buildTextField(documentoController, 'Documento')),
              SizedBox(width: 16),
              Expanded(child: buildTextField(celularController, 'Celular')),
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
              onPressed: _saveData,
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

  Future<void> _saveData() async {
    final Uri url = Uri.parse("http://localhost:8080/api/participante/atualizar?id=${id}");
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      'id' : id,
      'Nome': nomeController.text,
      'Documento': int.tryParse(documentoController.text) ?? 0,
      'NumContato': int.tryParse(celularController.text) ?? 0,
      'Email': emailController.text,
      'Endereco': enderecoController.text,
      'Fornecedor': isFornecedor,
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        setState(() {
          nomeController.clear();
          documentoController.clear();
          celularController.clear();
          emailController.clear();
          enderecoController.clear();
          isFornecedor = false;
        });
        _showMessage(context, "Dados salvos com sucesso", "Sucesso");
      } else {
        _showMessage(context, "A requisição falhou", "Erro");
      }
    } catch (e) {
      _showMessage(context, "Erro na requisição: $e", "Erro");
    }
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

  void _showMessage(BuildContext context, String message, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
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
}
