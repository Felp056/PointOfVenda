import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pov_web/afterLogin.dart';
import 'package:pov_web/pages/Cadastro/CadastroDeParticipante.dart';
import 'package:pov_web/pages/Cadastro/CadastroDeProduto.dart';
import 'package:pov_web/widgets/ProdFormDataToGrid.dart';
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
  List<Map<String, dynamic>> todosProdutos = [];
  int? selectedCodigoTabela; // Armazena o código da tabela selecionada

  @override
  void initState() {
    super.initState();
    _carregarTodosProdutos();
  }

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

  // Abre o popup para selecionar uma tabela de preço e carrega seus dados ao selecionar
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
                  title: Text(tabela["nomeTabela"] ?? ""),
                  subtitle: Text("Código: ${tabela["codigoTabela"] ?? ""}"),
                  onTap: () {
                    selectedCodigoTabela = tabela["codigoTabela"]; // Armazena o código da tabela selecionada
                    _carregarProdutos(selectedCodigoTabela!); // Carrega os produtos da tabela
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
          tabelasDePreco = data.map((item) => {
            "codigoTabela": item['codigoTabela'],
            "nomeTabela": item['nomeTabela'],
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
              "CodBarras": produto['CodBarras'] ?? "",
              "QtdDisponivel": produto['QtdDisponivel'] ?? 0,
              "Medida": produto['Medida'] ?? "",
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

  // Adiciona uma nova linha para adicionar um produto
  void _adicionarLinhaProduto() {
    setState(() {
      precos.add({
        "idProduto": null,
        "Descricao": null,
        "CodBarras": "",
        "QtdDisponivel": 0,
        "Medida": "",
        "Preco": 0.0,
        "Promocao": false,
      });
    });
  }

  // Remove o produto da tabela selecionada pelo índice
  void _removerProduto(int index) {
    setState(() {
      precos.removeAt(index);
    });
  }

  // Salva as alterações feitas na tabela de preço selecionada
  Future<void> _salvarAlteracoesTabelaDePreco() async {
    if (selectedCodigoTabela == null) {
      print("Nenhuma tabela de preço selecionada para salvar.");
      return;
    }

    final Uri url = Uri.parse("http://localhost:8080/api/tabelasPreco/salvar");

    final tabelaPrecoData = {
      "codigoTabela": selectedCodigoTabela,
      "nomeTabela": nomeController.text,
      "produtos": precos.map((produto) => {
        "idProduto": produto["idProduto"],
        "Descricao": produto["Descricao"],
        "CodBarras": produto["CodBarras"],
        "QtdDisponivel": produto["QtdDisponivel"],
        "Medida": produto["Medida"],
        "Preco": produto["Preco"],
        "Promocao": produto["Promocao"]
      }).toList(),
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(tabelaPrecoData),
      );

      if (response.statusCode == 201) {
        print("Tabela de preço e produtos salvos com sucesso!");
      } else {
        print("Erro ao salvar a tabela de preço: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro na requisição de salvamento: $e");
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
            // Campos de entrada para o cadastro de uma nova tabela
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
                    onPressed: _salvarAlteracoesTabelaDePreco, // Salva a tabela de preço
                    child: Text("Salvar Tabela", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Botões de Ações: Adicionar Linha, Pesquisar e Salvar Grade
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
                  onPressed: _mostrarPopupTabelasDePreco, // Abre popup para selecionar a tabela de preço
                  child: Icon(Icons.search, color: Colors.white, size: 28),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _salvarAlteracoesTabelaDePreco, // Salva as alterações na tabela selecionada
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

                      var produtoWidget = Prodformdatatogrid(
                        nome: produto["Descricao"] ?? "",
                        codBarras: produto["CodBarras"] ?? 0,
                        qtdDisponivel: produto["QtdDisponivel"] ?? 0,
                        medida: produto["Medida"] ?? "",
                        preco: produto["Preco"] ?? 0,
                        promocao: produto["Promocao"] ?? false,
                        id: produto["idProduto"] ?? 0,
                        onRemove: () => _removerProduto(index),
                      );

                      return produtoWidget.toDataRow();
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
