import 'package:flutter/material.dart';
import 'package:pov_web/DataModels/Produto.dart';
import 'package:pov_web/DataModels/cliente_model.dart';
import 'package:pov_web/database/db.dart';
import 'package:sqflite/sqflite.dart';

class PedidoRepository extends ChangeNotifier {
  late Database db;
  Cliente? _cliente;
  List<Produto> _produtos = [];

  get cliente => _cliente;
  List<Produto> get produtos => _produtos;

  PedidoRepository() {
    _initRepository();
  }

  _initRepository() async {
    _getProdutos;
  }

  _getProdutos() async {
    db = await DB.instance.database;
    List produtos = await db.query('produto');
    int index = 0;
    for (var produto in produtos) {
      _produtos = produto.firstAt[index];
      index++;
    }
    notifyListeners();
  }

  setCliente(Cliente cliente) async {
    db = await DB.instance.database;
    db.update('pedido', {
      'cliente': cliente,
    });
    _cliente = cliente;
    notifyListeners();
  }
}
