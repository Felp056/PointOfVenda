import 'package:flutter/material.dart';
import 'package:pov_web/DataModels/cliente_model.dart';

class WidgetCliente extends StatefulWidget {
  const WidgetCliente({
    super.key,
    required this.altura,
    required this.largura,
    required this.cliente,
  });

  final Cliente cliente;
  final double altura;
  final double largura;
  @override
  State<WidgetCliente> createState() => _WidgetClienteState();
}

class _WidgetClienteState extends State<WidgetCliente> {
  final Color bgColor = Colors.white;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  editCliente() {}

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: bgColor,
      title: Text(
        widget.cliente.nome,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        widget.cliente.documento,
        style: TextStyle(
          fontSize: 15,
          color: Colors.grey[700],
        ),
      ),
      leading: IconButton(
        onPressed: editCliente,
        icon: const Icon(Icons.person),
      ),
    );
  }
}

/*

Container(
      color: Colors.amberAccent,
      padding: EdgeInsets.only(bottom: widget.largura * .05),
      child: Row(
        children: [
          // Cliente
          Padding(
            padding: EdgeInsets.all(widget.largura * .1),
            child: Text('Cliente: ${widget.cliente.nome}'),
          ),
          // Endereço
          Padding(
            padding: EdgeInsets.all(widget.largura * .1),
            child: Text('Cliente: ${widget.cliente.endereco}'),
          ),
          // Documento
          Padding(
            padding: EdgeInsets.all(widget.largura * .1),
            child: Text('Cliente: ${widget.cliente.documento}'),
          ),
        ],
      ),
    );

*/