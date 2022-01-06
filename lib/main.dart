import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';

import 'package:provider/provider.dart';
import './home_page/home_page.dart';

void main() => runApp(MyHomePage());

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExpenseProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
