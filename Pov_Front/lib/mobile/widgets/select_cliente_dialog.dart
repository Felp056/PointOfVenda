import 'package:flutter/material.dart';
import 'package:pov_web/DataModels/cliente_model.dart';

class SelectCliente extends StatelessWidget {
  const SelectCliente({
    super.key,
    required this.cliente,
  });

  final Cliente cliente;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Selecionar Cliente',
        style: TextStyle(
          fontSize: 25,
          color: Colors.grey[700],
        ),
      ),
      content: ListView(
        children: [
          ListTile(
            title: Text(
              cliente.nome,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              cliente.documento,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
              ),
            ),
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person),
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(
              cliente.nome,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              cliente.documento,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
              ),
            ),
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop,
          child: const Text('CANCELAR'),
        ),
        TextButton(
          onPressed: () => Navigator.pop,
          child: const Text('SALVAR'),
        ),
      ],
    );
  }
}
