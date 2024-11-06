import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pov_web/pages/Cadastro/CadastroDeParticipante.dart';
import 'package:pov_web/pages/loginpadrao.dart';
import 'package:pov_web/mobile/loginMobile.dart';
import 'dart:io' show Platform;

void main() {
  if (kIsWeb) {
    runApp(const MyApp());
  } else if (Platform.isAndroid) {
    runApp(const MyAppMobile());
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
      home: CadastroParticipante(title: "Participante")
      // CadastroParticipante(title: "Participante")
      //loginpadrao(title: "P.O.V"),
    );
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
        home: LoginMobile(),
    );
    throw UnimplementedError();
  }
}