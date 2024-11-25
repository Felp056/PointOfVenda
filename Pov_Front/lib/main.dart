import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pov_web/DataModels/pedido.dart';
import 'package:pov_web/Repository/PedidoRepository.dart';
import 'package:pov_web/afterLogin.dart';
import 'package:pov_web/mobile/checkout_mobile.dart';
import 'package:pov_web/mobile/login_mobile.dart';
import 'dart:io' show Platform;

import 'package:pov_web/mobile/menu_mobile.dart';
import 'package:pov_web/mobile/venda_mobile.dart';
import 'package:provider/provider.dart';

void main() {
  if (kIsWeb) {
    runApp(const MyApp());
  } else if (Platform.isAndroid) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PedidoRepository()),
          ChangeNotifierProvider(create: (context) => Pedido())
        ],
        child: const MyAppMobile(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'P.O.V',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFEDF2F4)),
          useMaterial3: true,
        ),
        home: afterLogin(title: "P.O.V"));
  }
}

class MyAppMobile extends StatelessWidget {
  const MyAppMobile({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'P.O.V',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFEDF2F4)),
        useMaterial3: true,
      ),
      home: const LoginMobile(),
      routes: <String, WidgetBuilder>{
        '/loginpage': (BuildContext context) => const LoginMobile(),
        '/homepage': (BuildContext context) => const MenuMobile(),
        '/vendas': (BuildContext context) => VendaMobile(),
        '/checkout': (BuildContext context) => const CheckoutMobile(),
      },
    );
  }
}
