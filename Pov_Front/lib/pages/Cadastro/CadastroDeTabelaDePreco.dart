import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Cadastrodetabeladepreco extends StatefulWidget {
  Cadastrodetabeladepreco({super.key, required this.title});

  final String title;

  @override
  State<Cadastrodetabeladepreco> createState() => _CadastrodetabeladeprecoState();
}

class _CadastrodetabeladeprecoState extends State<Cadastrodetabeladepreco> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController codigoTabelaController = TextEditingController();
  List<Map<String, dynamic>> precos = [];
  List<Map<String, dynamic>> tabelasDePreco = []; // Lista para armazenar as tabelas de preço
  List<Map<String, dynamic>> todosProdutos = []; // Lista para todos os produtos para dropdown
  List<Map<String, dynamic>> produtosSelecionados = []; // Lista de produtos da tabela selecionada

  // Carrega a lista de todos os produtos para o dropdown
  Future<void> _carregarTodosProdutos() async {
    final Uri url = Uri.parse("http://localhost:8080/api/produtos");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          todosProdutos = data.map((produto) => {
            "idProduto": produto['idProduto'],
            "Descricao": produto['Descricao']
          }).toList();
        });
      } else {
        print("Erro ao carregar produtos: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro na requisição: $e");
    }
  }

  // Abre o popup de seleção de tabela de preço
  void _mostrarPopupTabelasDePreco() async {
    await _carregarTabelasDePreco();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Selecione uma Tabela de Preço"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: tabelasDePreco.length,
              itemBuilder: (BuildContext context, int index) {
                final tabela = tabelasDePreco[index];
                return ListTile(
                  title: Text(tabela["nomeTabela"]),
                  subtitle: Text("Código: ${tabela["codigoTabela"]}"),
                  onTap: () {
                    _carregarProdutos(tabela["codigoTabela"]);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  // Carrega as tabelas de preço disponíveis
  Future<void> _carregarTabelasDePreco() async {
    final Uri url = Uri.parse("http://localhost:8080/api/tabelasPreco");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          tabelasDePreco = data.map((item) {
            return {
              "codigoTabela": item['codigoTabela'],
              "nomeTabela": item['nomeTabela'],
            };
          }).toList();
        });
      } else {
        print("Erro ao carregar tabelas de preço: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro na requisição: $e");
    }
  }

  // Carrega os produtos para a tabela de preço selecionada
  Future<void> _carregarProdutos(int codigoTabela) async {
    final Uri url = Uri.parse("http://localhost:8080/api/preco/$codigoTabela");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        setState(() {
          precos = (data['produto'] as List).map((produto) {
            return {
              "idProduto": produto['idProduto'],
              "Descricao": produto['Descricao'],
              "CodBarras": produto['CodBarras'],
              "QtdDisponivel": produto['QtdDisponivel'] ?? 0,
              "Medida": produto['Medida'] ?? "",
              "Preco": data['Preco'] ?? 0.0,
              "Promocao": data['Promocao'] ?? false,
              "isSelected": false,
            };
          }).toList();
        });
      } else {
        print("Erro ao carregar produtos da tabela: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro na requisição: $e");
    }
  }

  // Adiciona uma nova linha para adicionar um produto
  void _adicionarLinhaProduto() async {
    if (todosProdutos.isEmpty) {
      await _carregarTodosProdutos(); // Carrega todos os produtos para o dropdown
    }

    setState(() {
      precos.add({
        "idProduto": null,
        "Descricao": null,
        "CodBarras": "",
        "QtdDisponivel": 0,
        "Medida": "",
        "Preco": 0.0,
        "Promocao": false,
        "isSelected": false,
      });
    });
  }

  // Remove o produto da tabela selecionada
  void _removerProduto(int index) {
    setState(() {
      precos.removeAt(index);
    });
  }

  // Salva a tabela de preço e seus produtos
  Future<void> _AddTabelaDePreco() async {
    final Uri url = Uri.parse("http://localhost:8080/api/tabelasPreco/salvar");
    final tabelaPreco = {
      "CodTabela": codigoTabelaController.text,
      "NomeTabela": nomeController.text,
      "produtos": null,
      "Promocao": false
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(tabelaPreco),
      );

      if (response.statusCode == 201) {
        print("Tabela de preço salva com sucesso!");
      } else {
        print("Erro ao salvar tabela de preço: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao enviar a requisição de salvamento: $e");
    }
  }


  Future<void> _salvarTabelaDePreco() async {
    final Uri url = Uri.parse("http://localhost:8080/api/tabelasPreco/salvar");

    final tabelaPrecoData = {
      "CodTabela": int.tryParse(codigoTabelaController.text) ?? 0,
      "NomeTabela": nomeController.text,
      "Promocao": false,  // ajuste conforme o tipo de dados para Promocao
      "produtos": precos
          .where((produto) => produto["idProduto"] != null)
          .map((produto) => {
        "idProduto": produto["idProduto"],
        "Descricao": produto["Descricao"],
        "CodBarras": produto["CodBarras"],
        "QtdDisponivel": produto["QtdDisponivel"],
        "Medida": produto["Medida"],
        "Preco": produto["Preco"]
      })
          .toList(),
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(tabelaPrecoData),
      );

      if (response.statusCode == 201) {
        print("Tabela de preço salva com sucesso!");
      } else {
        print("Erro ao salvar tabela de preço: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao enviar a requisição de salvamento: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width >= 600 ? 16 : 10;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastro de Tabela de Preço',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Color(0xff8D99AE),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width *0.95,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: nomeController,
                      decoration: InputDecoration(labelText: 'Nome:', border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: codigoTabelaController,
                      decoration: InputDecoration(labelText: 'Código da Tabela:', border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _AddTabelaDePreco,
                    child: Text("Salvar", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Botões de ação para Salvar e Deletar
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _salvarTabelaDePreco,
                  child: Text("Salvar", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _adicionarLinhaProduto,
                  child: Text("Adicionar Produto", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _mostrarPopupTabelasDePreco,
                  child: Icon(Icons.search, color: Colors.white, size: 28),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02)
              ],
            ),
            SizedBox(height: 16),

            // Tabela de produtos
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width *0.95,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: MediaQuery.of(context).size.width * 0.05,
                          headingRowHeight: 56,
                          columns: [
                            
                            DataColumn(label: Text("Nome", style: TextStyle(fontSize: fontSize))),
                            DataColumn(label: Text("Código de Barras", style: TextStyle(fontSize: fontSize))),
                            DataColumn(label: Text("Qtd Disponível", style: TextStyle(fontSize: fontSize))),
                            DataColumn(label: Text("Medida", style: TextStyle(fontSize: fontSize))),
                            DataColumn(label: Text("Preço", style: TextStyle(fontSize: fontSize))),
                            DataColumn(label: Text("Promoção", style: TextStyle(fontSize: fontSize))),
                            DataColumn(label: Text("Ações", style: TextStyle(fontSize: fontSize))),
                          ],
                          rows: precos.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, dynamic> produto = entry.value;
                            return DataRow(
                              cells: [
                                DataCell(
                                  produto["idProduto"] == null
                                      ? DropdownButton(
                                    value: produto["Descricao"],
                                    items: todosProdutos
                                        .map((prod) => DropdownMenuItem(
                                      value: prod["Descricao"],
                                      child: Text(prod["Descricao"]),
                                    ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        produto["Descricao"] = value;
                                        produto["idProduto"] = todosProdutos.firstWhere((prod) => prod["Descricao"] == value)["idProduto"];
                                      });
                                    },
                                  )
                                      : Text(produto["Descricao"] ?? ""),
                                ),
                                DataCell(Text(produto["CodBarras"].toString())),
                                DataCell(Text(produto["QtdDisponivel"].toString())),
                                DataCell(Text(produto["Medida"])),
                                DataCell(Text(produto["Preco"].toString())),
                                DataCell(Text(produto["Promocao"] ? "Sim" : "Não")),
                                DataCell(
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _removerProduto(index),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}