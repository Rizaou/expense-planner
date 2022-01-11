import 'package:flutter/material.dart';
import 'package:gelir_gider/database/database_provider_expenses.dart';

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  void changeTExt(String text) {
    setState(() {
      value = text;
    });
  }

  String value = 'Text';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('yeni')),
      body: Column(
        children: [
          Text(value),
          TextField(
            onChanged: (val) {
              var temp = DBHelperExpenses.temp(val, changeTExt);
            },
          ),
        ],
      ),
    );
  }
}
