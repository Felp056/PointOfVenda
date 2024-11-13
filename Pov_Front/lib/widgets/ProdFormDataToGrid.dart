import 'package:flutter/material.dart';

class Prodformdatatogrid extends StatefulWidget {
  final String nome;
  final int codBarras;
  final int qtdDisponivel;
  final String medida;
  final int preco;
  final bool promocao;
  final int id;
  final VoidCallback onRemove; // Callback para remover o widget

  Prodformdatatogrid({
    required this.nome,
    required this.codBarras,
    required this.qtdDisponivel,
    required this.medida,
    required this.preco,
    required this.promocao,
    required this.id,
    required this.onRemove, // Recebe o callback para remover
  });

  @override
  _ProdformdatatogridState createState() => _ProdformdatatogridState();
}

class _ProdformdatatogridState extends State<Prodformdatatogrid> {
  late TextEditingController nomeController;
  late TextEditingController codBarrasController;
  late TextEditingController qtdDisponivelController;
  late TextEditingController medidaController;
  late TextEditingController precoController;

  @override
  void initState() {
    super.initState();
    // Inicializando os controladores com os valores do construtor
    nomeController = TextEditingController(text: widget.nome);
    codBarrasController = TextEditingController(text: widget.codBarras.toString());
    qtdDisponivelController = TextEditingController(text: widget.qtdDisponivel.toString());
    medidaController = TextEditingController(text: widget.medida.toString());
    precoController = TextEditingController(text: widget.preco.toString());
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

  Widget baseCheckBox() {
    return Checkbox(
      value: widget.promocao,
      onChanged: (value) {
        setState(() {
          // Atualiza o estado do checkbox
          widget.promocao;
        });
      },
    );
  }

  void _removerProduto() {
    widget.onRemove(); // Chama o callback do widget pai para remover o item
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: buildTextField(nomeController, "Nome")),
        Expanded(child: buildTextField(codBarrasController, "Código de Barras")),
        Expanded(child: buildTextField(qtdDisponivelController, "Quantidade")),
        Expanded(child: buildTextField(medidaController, "Medida")),
        Expanded(child: buildTextField(precoController, "Preço")),
        Expanded(child: baseCheckBox()),
        IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: _removerProduto, // Chama a função ao clicar no ícone
        ),
      ],
    );
  }
}
