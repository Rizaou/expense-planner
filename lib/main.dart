import 'package:flutter/material.dart';
import 'package:gelir_gider/database/database_provider_incomes.dart';
import 'package:gelir_gider/methods/global_values.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/providers/income_provider.dart';
import 'package:gelir_gider/providers/program_settings_provider.dart';
import 'package:gelir_gider/screens/home_screen.dart';
import 'package:provider/provider.dart';

//TODO : Make detail widget
//TODO : Fix the color change problem when delete an expense
//TODO : The graph can't have more than 10 items.

void main() => runApp(MyHomePage());

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ExpenseProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => IncomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProgramSettings(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
