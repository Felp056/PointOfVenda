import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WidgetCliente extends StatefulWidget {
  WidgetCliente({super.key});

  @override
  State<WidgetCliente> createState() => _WidgetClienteState();
}

class _WidgetClienteState extends State<WidgetCliente> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.amberAccent,
      margin: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      padding: EdgeInsets.all(5),
      child: Row(
        //color: Color.fromRGBO(218, 210, 216, 1),
        //child: Container(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("Cliente"),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("data"),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("test"),
          ),
        ],
      ),
    );
  }
}
