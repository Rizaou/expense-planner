import 'package:flutter/material.dart';
import 'package:gelir_gider/database/database_providder_program_settings.dart';
import 'package:gelir_gider/database/database_provider_incomes.dart';
import 'package:gelir_gider/methods/global_values.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/providers/income_provider.dart';
import 'package:gelir_gider/providers/program_settings_provider.dart';
import 'package:gelir_gider/screens/home_screen.dart';
import 'package:gelir_gider/screens/introduction_screen.dart.dart';
import 'package:provider/provider.dart';
import './database/database_providder_program_settings.dart';

//TODO : Make detail widget
void main() => runApp(MyHomePage());

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget mainScreen = Center(
      child: CircularProgressIndicator(),
    );
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
        theme: ThemeData(
            //scaffoldBackgroundColor: scaffoldBGColor,
            ),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: getFirstScreen.then((value) => mainScreen = value),
          builder: (context, snapshot) {
            return mainScreen;
          },
        ),
      ),
    );
  }
}
