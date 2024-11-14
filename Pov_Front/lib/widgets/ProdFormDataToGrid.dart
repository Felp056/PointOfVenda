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

  // Método auxiliar que converte para DataRow
  DataRow toDataRow() {
    return DataRow(
      cells: [
        DataCell(Text(nome.isNotEmpty ? nome : '-')),
        DataCell(Text(codBarras > 0 ? codBarras.toString() : '-')),
        DataCell(Text(qtdDisponivel > 0 ? qtdDisponivel.toString() : '-')),
        DataCell(Text(medida.isNotEmpty ? medida : '-')),
        DataCell(Text(preco > 0 ? preco.toString() : '-')),
        DataCell(
          Checkbox(
            value: promocao,
            onChanged: (value) {
              // Lógica para atualização do valor da promoção
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

class _ProdformdatatogridState extends State<Prodformdatatogrid> {
  late TextEditingController nomeController;
  late TextEditingController codBarrasController;
  late TextEditingController qtdDisponivelController;
  late TextEditingController medidaController;
  late TextEditingController precoController;
  late bool promocaoValue;

  @override
  void initState() {
    super.initState();
    // Inicializando os controladores com os valores do construtor
    nomeController = TextEditingController(text: widget.nome);
    codBarrasController = TextEditingController(text: widget.codBarras.toString());
    qtdDisponivelController = TextEditingController(text: widget.qtdDisponivel.toString());
    medidaController = TextEditingController(text: widget.medida);
    precoController = TextEditingController(text: widget.preco.toString());
    promocaoValue = widget.promocao;
  }

  @override
  Widget build(BuildContext context) {
    // Este widget pode ser utilizado para construir a interface onde os dados são editáveis
    return Row(
      children: [
        Expanded(child: buildOptionalTextField(nomeController, "Nome")),
        Expanded(child: buildOptionalTextField(codBarrasController, "Código de Barras", isNumeric: true)),
        Expanded(child: buildOptionalTextField(qtdDisponivelController, "Quantidade", isNumeric: true)),
        Expanded(child: buildOptionalTextField(medidaController, "Medida")),
        Expanded(child: buildOptionalTextField(precoController, "Preço", isNumeric: true)),
        Expanded(child: baseCheckBox()),
        IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: widget.onRemove, // Chama o callback para remover
        ),
      ],
    );
  }

  // Função para construir um TextField opcional, que pode ou não ter valor
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

  // Função para criar um Checkbox de promoção
  Widget baseCheckBox() {
    return Checkbox(
      value: promocaoValue,
      onChanged: (value) {
        setState(() {
          promocaoValue = value ?? false;
        });
      },
    );
  }
}
