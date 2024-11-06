import 'package:flutter/material.dart';

class CadastroParticipante extends StatefulWidget {
  const CadastroParticipante({super.key,  required this.title});
  final String title;
  @override
  State<CadastroParticipante> createState() => _CadastroParticipante();
}

class _CadastroParticipante extends State<CadastroParticipante> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Participante', style: TextStyle(color: Colors.white, fontSize: 40),),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      backgroundColor: Color(0xff8D99AE),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Primeiro container fixo
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xffEDF2F4), // Cor de fundo do container
                    border: Border.all(
                      color: Colors.black, // Cor da borda
                      width: 2.0, // Espessura da borda
                    ),
                    borderRadius: BorderRadius.circular(30), // Arredondamento dos cantos da borda
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      CadastroForm(isLargeScreen: constraints.maxWidth >= 600),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                // Containers expansíveis
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffEDF2F4), // Cor de fundo do container
                    border: Border.all(
                      color: Colors.black, // Cor da borda
                      width: 2.0, // Espessura da borda
                    ),
                    borderRadius: BorderRadius.circular(30), // Arredondamento dos cantos da borda
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: ExpansionTile(
                      title: Text(
                        'Luís do teste de Participante', //isso vai virar variavel
                        style: TextStyle(color: Colors.black),
                      ),
                      tilePadding: EdgeInsets.symmetric(horizontal: 16.0),
                      backgroundColor: Color(0xffEDF2F4),
                      collapsedBackgroundColor: Color(0xffEDF2F4),
                      initiallyExpanded: false,
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.0),
                          child: CadastroFornecedorForm(isLargeScreen: constraints.maxWidth >= 600),
                        ),
                      ],
                    ),
                  )
                )
                // Adicione mais ExpansionTiles aqui, se necessário
              ],
            ),
          );
        },
      ),
    );
  }
}

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
  final TextEditingController creditoController = TextEditingController();
  bool isFornecedor = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          widget.isLargeScreen
              ? Row(
            children: [
              Expanded(child: buildTextField(documentoController, 'Documento')),
              SizedBox(width: 16),
              Expanded(child: buildTextField(celularController, 'Celular')),
            ],
          )
              : buildTextField(documentoController, 'Documento'),
          SizedBox(height: 16),
          buildTextField(enderecoController, 'Endereço'),
          SizedBox(height: 16),
          widget.isLargeScreen
              ? Row(
            children: [
              Expanded(child: buildTextField(creditoController, 'Crédito')),
              SizedBox(width: 16),
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
            ],
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField(creditoController, 'Crédito'),
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
            ],
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                // Implementar lógica para salvar o formulário
              },
              child: Text('Salvar', style:TextStyle( color: Colors.black, fontSize: 15)),
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

class CadastroFornecedorForm extends StatelessWidget {
  final bool isLargeScreen;

  CadastroFornecedorForm({required this.isLargeScreen});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isLargeScreen
            ? Row(
          children: [
            Expanded(child: buildTextField('Nome do Fornecedor')),
            SizedBox(width: 16),
            Expanded(child: buildTextField('Documento')),
          ],
        )
            : buildTextField('Nome do Fornecedor'),
        SizedBox(height: 16),
        isLargeScreen
            ? Row(
          children: [
            Expanded(child: buildTextField('Celular')),
            SizedBox(width: 16),
            Expanded(child: buildTextField('Email')),
          ],
        )
            : buildTextField('Celular'),
        SizedBox(height: 16),
        buildTextField('Endereço'),
        SizedBox(height: 16),
        buildTextField('Crédito'),
        SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {
              // Implementar lógica para salvar o formulário
            },
            child: Text('Salvar', style:TextStyle( color: Colors.black, fontSize: 15)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffEC9A29),
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTextField(String label) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}