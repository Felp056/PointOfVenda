import 'package:flutter/material.dart';

class DropMenu extends StatefulWidget {
  final Function(String mainMenu, String subMenu) onMenuTap;

  DropMenu({required this.onMenuTap, Key? key}) : super(key: key);

  @override
  _DropMenuState createState() => _DropMenuState();
}

class _DropMenuState extends State<DropMenu> {
  String? _selectedMenu; // Variável para controlar o submenu ativo

  // Define os itens do menu principal e seus respectivos submenus
  final Map<String, List<String>> _submenuItems = {
    "Cadastro": ["Participante", "Produto", "Tabela de Preço", "Acesso"],
    "Financeiro": ["Contas a Pagar", "Contas a Receber"],
    "Estoque": ["Entrada", "Saída por Produto"],
    "Relatórios": ["Em produção"]
  };

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Menu principal
        Drawer(
          child: Container(
            color: Color(0xff8D99AE),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70,
                  child: DrawerHeader(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: IconButton(
                      alignment: AlignmentDirectional.center,
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                // Expande os itens do menu principal para ocupar o restante da altura
                Expanded(
                  child: ListView(
                    children: _submenuItems.keys.map((menu) {
                      Color backgroundColor = _selectedMenu == menu
                          ? Color(0xffEF233C)
                          : Color(0xff2B2D42);
                      return ListTile(
                        title: Container(
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Text(
                            menu,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        onTap: () {
                          // Ao clicar em um item do menu principal, abre o submenu correspondente
                          setState(() {
                            _selectedMenu = menu;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Submenu que aparece ao lado, apenas se _selectedMenu não for nulo
        if (_selectedMenu != null)
          Positioned(
            left: 150, // Ajuste a posição para o seu layout
            top: 70,
            bottom: 0,
            child: Container(
              width: 175,
              decoration: BoxDecoration(color: Color(0xff8D99AE)),
              child: ListView(
                children: _submenuItems[_selectedMenu]!
                    .map((item) => ListTile(
                          title: Container(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                color: Color(0xff2B2D42),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7))),
                            height: 30,
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              item,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () {
                            // Chama a função onMenuTap ao clicar no submenu
                            widget.onMenuTap(_selectedMenu!, item);
                          },
                        ))
                    .toList(),
              ),
            ),
          ),
      ],
    );
  }
}