import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pov_web/afterLogin.dart';
import 'package:pov_web/pages/Cadastro/CadastroDeParticipante.dart';
import 'package:pov_web/pages/Cadastro/CadastroDeProduto.dart';
import 'package:pov_web/widgets/dropMenu.dart';

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
  List<Map<String, dynamic>> tabelasDePreco = [];
  int? selectedCodigoTabela;
  int? idTabela;

  @override
  void initState() {
    super.initState();
    _carregarTodosProdutos();
  }

  // Carrega todos os produtos
  Future<void> _carregarTodosProdutos() async {
    final Uri url = Uri.parse("http://localhost:8080/api/produtos");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          precos = [];
        });
      } else {
        print("Erro ao carregar produtos: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao carregar produtos: $e");
    }
  }

  // Carrega todas as tabelas de preço
  Future<void> _carregarTabelasDePreco() async {
    final Uri url = Uri.parse("http://localhost:8080/api/preco/todas");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          tabelasDePreco = data.map((tabela) {
            return {
              "id": tabela['id'],
              "CodTabela": tabela['CodTabela'],
              "NomeTabela": tabela['NomeTabela'],
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

  // Mostra popup para selecionar uma tabela de preço
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
              itemBuilder: (context, index) {
                final tabela = tabelasDePreco[index];
                return ListTile(
                  title: Text("Nome: ${tabela['NomeTabela'] ?? ''}"),
                  subtitle: Text("Código: ${tabela['CodTabela'] ?? ''}"),
                  onTap: () {
                    selectedCodigoTabela = tabela['CodTabela'];
                    idTabela = tabela['id'];
                    nomeController.text = tabela['NomeTabela'] ?? '';
                    codigoTabelaController.text = selectedCodigoTabela.toString();
                    _carregarProdutosDaTabela(selectedCodigoTabela!);
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

  // Carrega os produtos da tabela selecionada
  Future<void> _carregarProdutosDaTabela(int codigoTabela) async {
    final Uri url = Uri.parse("http://localhost:8080/api/preco/$codigoTabela");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          precos = (data['produto'] as List).map((produto) {
            return {
              "idProduto": produto['idProduto'],
              "Descricao": produto['Descricao'],
              "CodBarras": produto['CodBarras'] ?? '',
              "QtdDisponivel": produto['QtdDisponivel'] ?? 0,
              "Medida": produto['Medida'] ?? '',
              "Preco": produto['Preco'] ?? 0.0,
              "Promocao": produto['Promocao'] ?? false,
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

  // Remove o produto de uma linha
  void _removerProduto(int index) {
    setState(() {
      precos.removeAt(index);
    });
  }

  // Salva as alterações feitas
  Future<void> _salvarAlteracoesTabelaDePreco() async {
    try {
      // 1. Obter lista de produtos do backend
      final Uri urlProdutos = Uri.parse("http://localhost:8080/api/produto/todas");
      final response = await http.get(urlProdutos);

      if (response.statusCode != 200) {
        print("Erro ao buscar lista de produtos: ${response.statusCode}");
        return;
      }

      // Decodificar lista de produtos
      List<dynamic> produtosBackend = json.decode(response.body);

      // 2. Atualizar os IDs dos produtos no array `precos`
      for (var produto in precos) {
        // Busca o produto no backend com base na Descrição ou outro critério
        final produtoCorrespondente = produtosBackend.firstWhere(
              (p) => p["CodBarras"] == produto["CodBarras"], // Critério de comparação
          orElse: () => null,
        );

        if (produtoCorrespondente != null) {
          produto["idProduto"] = produtoCorrespondente["idProduto"];
        } else {
          print("Produto não encontrado no backend: ${produto["Descricao"]}");
        }
      }

      // 3. Criar objeto para envio
      final tabelaPrecoData = {
        "id": idTabela,
        "CodTabela": selectedCodigoTabela ?? codigoTabelaController.text,
        "NomeTabela": nomeController.text,
        "Promocao": false,
        "Produtos": precos, // Produtos atualizados com IDs
      };

      // 4. Enviar os dados ao backend
      final dio = Dio();
      final Uri urlSalvar = selectedCodigoTabela == null
          ? Uri.parse("http://localhost:8080/api/preco/adicionar")
          : Uri.parse("http://localhost:8080/api/preco/atualizar?id=$selectedCodigoTabela");

      final responseSalvar = await dio.postUri(
        urlSalvar,
        options: Options(contentType: 'application/json'),
        data: json.encode(tabelaPrecoData),
      );

      if (responseSalvar.statusCode == 200) {
        print("Tabela de preço e produtos salvos com sucesso!");
      } else {
        print("Erro ao salvar tabela de preço: ${responseSalvar.statusCode}");
      }
    } catch (e) {
      print("Erro ao salvar tabela de preço: $e");
    }
  }

// Adiciona uma nova linha com valores padrão
  void _adicionarLinhaProduto() {
    setState(() {
      precos.add({
        "idProduto": null,
        "Descricao": '',
        "CodBarras": '',
        "QtdDisponivel": 0,
        "Medida": '',
        "Preco": 0.0,
        "Promocao": false,
      });
    });
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
      drawer: DropMenu(onMenuTap: (mainMenu, subMenu) {
        Widget targetPage;
        switch (subMenu) {
          case "Participante":
            targetPage = CadastroParticipante(title: "Cadastro de Participante");
            break;
          case "Produto":
            targetPage = Cadastrodeproduto(title: "Cadastro de Produto");
            break;
          case "Tabela de Preço":
            targetPage = Cadastrodetabeladepreco(title: "Cadastro de Tabela de Preço");
            break;
          default:
            targetPage = afterLogin(title: "P.O.V");
            break;
        }
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => targetPage));
      }),
      backgroundColor: Color(0xff8D99AE),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Campos de entrada para cadastro
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
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
                    onPressed: _salvarAlteracoesTabelaDePreco,
                    child: Text("Salvar Tabela", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Botões de ações
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _adicionarLinhaProduto,
                  child: Text("Adicionar Linha", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _mostrarPopupTabelasDePreco,
                  child: Icon(Icons.search, color: Colors.white, size: 28),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _salvarAlteracoesTabelaDePreco,
                  child: Text("Salvar Alterações", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Tabela de produtos
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: MediaQuery.of(context).size.width * 0.095,
                    headingRowHeight: 56,
                    columns: [
                      DataColumn(label: Expanded(child: Text("Nome", style: TextStyle(fontSize: fontSize)))),
                      DataColumn(label: Expanded(child: Text("Código de Barras", style: TextStyle(fontSize: fontSize)))),
                      DataColumn(label: Expanded(child: Text("Qtd Disponível", style: TextStyle(fontSize: fontSize)))),
                      DataColumn(label: Expanded(child: Text("Medida", style: TextStyle(fontSize: fontSize)))),
                      DataColumn(label: Expanded(child: Text("Preço", style: TextStyle(fontSize: fontSize)))),
                      DataColumn(label: Expanded(child: Text("Promoção", style: TextStyle(fontSize: fontSize)))),
                      DataColumn(label: Expanded(child: Text("Ações", style: TextStyle(fontSize: fontSize)))),
                    ],
                    rows: precos.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> produto = entry.value;

                      return DataRow(
                        cells: [
                          DataCell(TextField(
                            controller: TextEditingController(text: produto["Descricao"]),
                            onChanged: (value) => precos[index]["Descricao"] = value,
                          )),
                          DataCell(TextField(
                            controller: TextEditingController(text: produto["CodBarras"].toString()),
                            onChanged: (value) => precos[index]["CodBarras"] = int.tryParse(value) ?? 0,
                          )),
                          DataCell(TextField(
                            controller: TextEditingController(text: produto["QtdDisponivel"].toString()),
                            onChanged: (value) => precos[index]["QtdDisponivel"] = int.tryParse(value) ?? 0,
                          )),
                          DataCell(TextField(
                            controller: TextEditingController(text: produto["Medida"]),
                            onChanged: (value) => precos[index]["Medida"] = value,
                          )),
                          DataCell(TextField(
                            controller: TextEditingController(text: produto["Preco"].toString()),
                            onChanged: (value) => precos[index]["Preco"] = double.tryParse(value) ?? 0.0,
                          )),
                          DataCell(Checkbox(
                            value: produto["Promocao"],
                            onChanged: (value) => setState(() => precos[index]["Promocao"] = value ?? false),
                          )),
                          DataCell(IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removerProduto(index),
                          )),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
