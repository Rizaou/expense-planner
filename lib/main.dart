import 'package:flutter/material.dart';
import 'package:gelir_gider/database/database_providder_program_settings.dart';
import 'package:gelir_gider/database/database_provider_expenses.dart';
import 'package:gelir_gider/database/database_provider_incomes.dart';
import 'package:gelir_gider/methods/global_values.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/providers/income_provider.dart';
import 'package:gelir_gider/providers/program_settings_provider.dart';
import 'package:gelir_gider/screens/home_screen.dart';
import 'package:gelir_gider/screens/introduction_screen.dart.dart';
import 'package:provider/provider.dart';
import './database/database_providder_program_settings.dart';
import './database/database_provider_expenses.dart';

//TODO : Make detail widget
//TODO : Ask for a quastion to the user that which credit card they want to add .
//TODO : Make annual statistic
//TODO : MAke animated Container.
//TODO: Add some columns to DB that names are year, month ,date and DateTime.
void main() => runApp(MyHomePage());

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DBHelperExpenses.descOrder;
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
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.green.shade900,
          // colorScheme: ColorScheme.dark().copyWith(
          //     background: Colors.black, primary: Colors.green.shade900),
          // accentColor: ,
          scaffoldBackgroundColor: Colors.black,
          cardColor: Color.fromARGB(255, 12, 39, 28),
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
