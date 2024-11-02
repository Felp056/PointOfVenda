import 'package:flutter/material.dart';
import 'package:pov_web/pages/loginpadrao.dart';

void main() {
  runApp(const MyApp());
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
      home: loginpadrao(title: "P.O.V"),
    );
  }
}