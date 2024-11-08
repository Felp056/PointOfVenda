import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pov_web/pages/Cadastro/CadastroDeParticipante.dart';
import '../../afterLogin.dart';
import '../../widgets/dropMenu.dart';

class Cadastrodeproduto extends StatefulWidget {
  Cadastrodeproduto({super.key, required this.title});

  final String title;

  @override
  State<Cadastrodeproduto> createState() => _CadastrodeprodutoState();
}

class _CadastrodeprodutoState extends State<Cadastrodeproduto> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController codigoBarrasController = TextEditingController();
  final TextEditingController qtdDisponivelController = TextEditingController();
  List<Map<String, dynamic>> produtos = [];

  @override
  void initState() {
    super.initState();
    _carregarProdutos();
  }

  // Função para carregar dados da API
  Future<void> _carregarProdutos() async {
    final Uri url = Uri.parse("http://localhost:8080/api/produto/todas");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        print(
            "Dados recebidos: $data"); // Debug: Verifica o JSON bruto recebido

        setState(() {
          produtos = data.map((item) {
            return {
              "idProduto": item['idProduto'],
              "Descricao": TextEditingController(text: item['Descricao'] ?? ""),
              "CodBarras": TextEditingController(
                  text: item['CodBarras'].toString() ?? ""),
              "QtdDisponivel": TextEditingController(
                  text: (item['QtdDisponivel'].toString() ?? "")),
              "Medida": item['Medida'] ?? "",
              "isSelected": false, // Checkbox para seleção
            };
          }).toList();
          print(
              "Produtos processados: $produtos"); // Debug: Verifica o mapeamento
        });
      } else {
        print("Erro ao carregar dados: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro na requisição: $e");
    }
  }

  // Função para adicionar um novo produto
  Future<void> _adicionarProduto() async {
    final Uri url = Uri.parse("http://localhost:8080/api/produto/adicionar");
    final Map<String, dynamic> novoProduto = {
      "Descricao": nomeController.text,
      "CodBarras": codigoBarrasController.text,
      "QtdDisponivel": qtdDisponivelController.text,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(novoProduto),
      );

      if (response.statusCode == 201) {
        nomeController.clear();
        codigoBarrasController.clear();
        qtdDisponivelController.clear();
        await _carregarProdutos();
      } else {
        print("Erro ao adicionar produto: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro na requisição ao adicionar produto: $e");
    }
  }

  // Função para salvar alterações de produtos
  Future<void> _salvarAlteracoes() async {
    for (var produto in produtos) {
      final Uri url = Uri.parse(
          "http://localhost:8080/api/produto/atualizar?id=${produto['idProduto']}");
      final Map<String, dynamic> atualizadoProduto = {
        "idProduto": produto["idProduto"],
        "Descricao": produto['Descricao'].text,
        "CodBarras": produto['CodBarras'].text,
        "QtdDisponivel": produto['QtdDisponivel'].text,
        "Medida": ""
      };

      try {
        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: json.encode(atualizadoProduto),
        );

        if (response.statusCode != 200) {
          print(
              "Erro ao atualizar produto ${produto['idProduto']}: ${response.statusCode}");
        }
      } catch (e) {
        print(
            "Erro na requisição ao atualizar produto ${produto['idProduto']}: $e");
      }
    }
    _carregarProdutos(); // Recarrega a lista após salvar
  }

  // Função para deletar produtos selecionados
  Future<void> _deletarProdutos() async {
    for (var produto in produtos.where((p) => p['isSelected'])) {
      final Uri url = Uri.parse(
          "http://localhost:8080/api/produto/delete?id=${produto['idProduto']}");
      try {
        final response = await http.delete(url);

        if (response.statusCode != 200) {
          print(
              "Erro ao deletar produto ${produto['idProduto']}: ${response.statusCode}");
        }
      } catch (e) {
        print(
            "Erro na requisição ao deletar produto ${produto['idProduto']}: $e");
      }
    }
    _carregarProdutos(); // Recarrega a lista após deletar
  }

  @override
  Widget build(BuildContext context) {
    // Calcula o tamanho da fonte proporcionalmente ao tamanho da tela
    double fontSize = MediaQuery.of(context).size.width >= 768
        ? 16.0
        : MediaQuery.of(context).size.width * 0.03;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastro de Produto',
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Color(0xff8D99AE),
      drawer: DropMenu(onMenuTap: (mainMenu, subMenu) {
        Widget targetPage;
        switch (subMenu) {
          case "Participante":
            targetPage =
                CadastroParticipante(title: "Cadastro de Participante");
            break;
          case "Produto":
            targetPage = Cadastrodeproduto(title: "Cadastro de Produto");
            break;
          default:
            targetPage = afterLogin(title: "P.O.V");
            break;
        }
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => targetPage),
        );
      }),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.fromLTRB(constraints.maxWidth * 0.03, 16.00,
                constraints.maxWidth * 0.03, 0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: nomeController,
                              decoration: InputDecoration(
                                labelText: 'Nome:',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: TextField(
                              controller: codigoBarrasController,
                              decoration: InputDecoration(
                                labelText: 'Código de Barras:',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: qtdDisponivelController,
                              decoration: InputDecoration(
                                labelText: 'Quantidade:',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          ElevatedButton(
                            onPressed: _adicionarProduto,
                            child: Text("Adicionar Produto",
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffEC9A29),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _salvarAlteracoes,
                      child: Text("Salvar Alterações",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _deletarProdutos,
                      child: Text("Deletar Selecionados",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Expanded(
                  child: Container(
                    width: constraints.maxWidth,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DataTable(
                      columnSpacing: 20,
                      // Aumenta o espaçamento entre as colunas
                      headingRowHeight: 56,
                      columns: [
                        DataColumn(
                          label: Center(
                            child: Text(
                              "Nome",
                              style: TextStyle(fontSize: fontSize),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Center(
                            child: Text(
                              "Código de Barras",
                              style: TextStyle(fontSize: fontSize),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Center(
                            child: Text(
                              "Quantidade",
                              style: TextStyle(fontSize: fontSize),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Center(
                            child: Text(
                              "Selecionar",
                              style: TextStyle(fontSize: fontSize),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                      rows: produtos.map((produto) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Container(
                                alignment: Alignment.center,
                                child: TextField(
                                  textAlign: TextAlign.left,
                                  controller: produto["Descricao"],
                                  style: TextStyle(fontSize: fontSize),
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                alignment: Alignment.center,
                                child: TextField(
                                  textAlign: TextAlign.left,
                                  controller: produto["CodBarras"],
                                  style: TextStyle(fontSize: fontSize),
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                alignment: Alignment.center,
                                child: TextField(
                                  textAlign: TextAlign.left,
                                  controller: produto["QtdDisponivel"],
                                  style: TextStyle(fontSize: fontSize),
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ),
                            DataCell(
                              Checkbox(
                                value: produto["isSelected"],
                                onChanged: (bool? value) {
                                  setState(() {
                                    produto["isSelected"] = value ?? false;
                                  });
                                },
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
          );
        },
      ),
    );
  }
}
