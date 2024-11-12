import 'package:flutter/material.dart';

class Prodformdatatogrid extends StatefulWidget{
  final String nome;
  final int codBarras;
  final int qtdDisponivel;
  final String medida;
  final int preco;
  final bool promocao;

  Prodformdatatogrid({
      required this.nome,
      required this.codBarras,
      required this.qtdDisponivel,
      required this.medida,
      required this.preco,
      required this.promocao
});
  @override
  _Prodformdatatogrid createState() => _Prodformdatatogrid();
}
class _Prodformdatatogrid extends State<Prodformdatatogrid>{
  @override
  Widget build(BuildContext context) {
    late TextEditingController nomeController;
    late TextEditingController codBarrasController;
    late TextEditingController qtdDisponivelController;
    late TextEditingController medidaController;
    late TextEditingController precoController;
    late Checkbox promocaoController;

    @override
    void initState() {
      super.initState();

      // Inicializando os controladores com os valores do construtor
      nomeController = TextEditingController(text: widget.nome);
      codBarrasController = TextEditingController(text: widget.codBarras.toString());
      qtdDisponivelController = TextEditingController(text: widget.qtdDisponivel.toString());
      medidaController = TextEditingController(text: widget.medida.toString());
      precoController = TextEditingController(text: widget.preco.toString());
      promocaoController = Checkbox(value: widget.promocao, onChanged: (value) => widget.promocao);
    }
    return Row(

    );
  }
}