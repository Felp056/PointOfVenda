import 'package:flutter/material.dart';

class Prodformdatatogrid extends StatefulWidget {
  final String nome;
  final int codBarras;
  final int qtdDisponivel;
  final String medida;
  final double preco;
  bool promocao;
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
    required this.onRemove,
  });

  Map<String, dynamic> getValues() {
    return {
      "idProduto": id,
      "Descricao": nomeController.text,
      "CodBarras": int.tryParse(codBarrasController.text) ?? 0,
      "QtdDisponivel": int.tryParse(qtdDisponivelController.text) ?? 0,
      "Medida": medidaController.text,
      "Preco": double.tryParse(precoController.text) ?? 0.0,
      "Promocao": promocao,
    };
  }


  void clearValues() {
    nomeController.clear();
    codBarrasController.clear();
    qtdDisponivelController.clear();
    medidaController.clear();
    precoController.clear();
    promocao = false; // Reseta o valor do checkbox
  }

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController codBarrasController = TextEditingController();
  final TextEditingController qtdDisponivelController = TextEditingController();
  final TextEditingController medidaController = TextEditingController();
  final TextEditingController precoController = TextEditingController();

  @override
  _ProdformdatatogridState createState() => _ProdformdatatogridState();

  DataRow toDataRow() {
    return DataRow(
      cells: [
        DataCell(Expanded(child: buildOptionalTextField(nomeController, nome ?? nome)),),
        DataCell( Expanded(child: buildOptionalTextField(codBarrasController, codBarras.toString() ?? codBarras.toString(), isNumeric: true))),
        DataCell( Expanded(child: buildOptionalTextField(qtdDisponivelController, qtdDisponivel.toString() ?? qtdDisponivel.toString(), isNumeric: true))),
        DataCell(Expanded(child: buildOptionalTextField(medidaController, medida ?? medida))),
        DataCell( Expanded(child: buildOptionalTextField(precoController, preco.toString() ?? preco.toString(), isNumeric: true))),
        DataCell(
          Checkbox(
            value: promocao,
            onChanged: (value) {
              promocao = value ?? false;
            },
          ),
        ),
        DataCell(
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: onRemove, // Chamando o callback para remover a linha
          ),
        ),
      ],
    );
  }
}
Widget buildOptionalTextField(TextEditingController controller, String label, {bool isNumeric = false}) {
  return TextField(
    controller: controller,
    keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
      hintText: 'Opcional', // Sugestão de texto para campo vazio
    ),
  );
}

class _ProdformdatatogridState extends State<Prodformdatatogrid> {
  late TextEditingController nomeController = TextEditingController();
  late TextEditingController codBarrasController = TextEditingController();
  late TextEditingController qtdDisponivelController= TextEditingController();
  late TextEditingController medidaController= TextEditingController();
  late TextEditingController precoController= TextEditingController();
  late bool promocaoValue;

  @override
  void initState() {
    super.initState();
    widget.nomeController.text = widget.nome;
    widget.codBarrasController.text = widget.codBarras.toString();
    widget.qtdDisponivelController.text = widget.qtdDisponivel.toString();
    widget.medidaController.text = widget.medida;
    widget.precoController.text = widget.preco.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildTextField(widget.nomeController, "Nome")),
        Expanded(child: _buildTextField(widget.codBarrasController, "Código de Barras", isNumeric: true)),
        Expanded(child: _buildTextField(widget.qtdDisponivelController, "Quantidade", isNumeric: true)),
        Expanded(child: _buildTextField(widget.medidaController, "Medida")),
        Expanded(child: _buildTextField(widget.precoController, "Preço", isNumeric: true)),
        Expanded(child: _buildCheckbox()),
        IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: widget.onRemove,
        ),
      ],
    );
  }


  Widget _buildTextField(TextEditingController controller, String label, {bool isNumeric = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }


  // Função para criar um Checkbox de promoção
  Widget _buildCheckbox() {
    return Checkbox(
      value: widget.promocao,
      onChanged: (value) {
        setState(() {
          widget.promocao = value ?? false;
        });
      },
    );
  }
}
