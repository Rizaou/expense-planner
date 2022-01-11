import 'package:flutter/material.dart';
import 'package:gelir_gider/database/database_provider_expenses.dart';
import 'package:gelir_gider/database/database_provider_incomes.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/providers/income_provider.dart';

import 'package:provider/provider.dart';
import './home_page/home_page.dart';

void main() => runApp(MyHomePage());

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // DBHelperExpenses.temp();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ExpenseProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => IncomeProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
