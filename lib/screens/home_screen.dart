import 'package:gelir_gider/example.dart';
import 'package:gelir_gider/methods/global_values.dart';
import 'package:gelir_gider/models/expense_model.dart';
import 'package:gelir_gider/models/income_model.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/providers/income_provider.dart';
import 'package:gelir_gider/widgets/custom_action_button.dart';
import 'package:gelir_gider/widgets/detail_widget.dart';
import 'package:gelir_gider/widgets/dialog_add_income.dart';
import 'package:gelir_gider/widgets/expense-card.dart';
import 'package:gelir_gider/widgets/graphic.dart';
import 'package:gelir_gider/widgets/income_card.dart';
import 'package:gelir_gider/widgets/main_incomes_chart.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter/material.dart';
import '../widgets/dialog_add_expense.dart';
import '../providers/program_settings_provider.dart';
import '../widgets/create_main_list.dart';

class HomeScreen extends StatefulWidget {
  final _HomeScreenState screen = _HomeScreenState();

  List<ExpenseModel> expenseData = [];
  List<IncomeModel> incomeData = [];

  void moveToGraph() {
    screen.focus(0);
  }

  void moveToExpenses() {
    screen.focus(2);
  }

  void moveToIncomes() {}

  @override
  State<HomeScreen> createState() => screen;
}

class _HomeScreenState extends State<HomeScreen> {
  final control = ItemScrollController();

  void focus(int index) {
    control.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    final expensesProvider = Provider.of<ExpenseProvider>(context);
    final incomeProvider = Provider.of<IncomeProvider>(context);
    final programSettings = Provider.of<ProgramSettings>(context);
    return Scaffold(
      // appBar: AppBar(
      //   //backgroundColor: scaffoldBGColor,
      //   title: Text(programSettings.tr_text["home_page"]),
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           AddIncome().getDialog(context);
      //         },
      //         icon: const Icon(Icons.flag)),
      //     IconButton(
      //       onPressed: () {
      //         AddExpense().getDialog(context);
      //       },
      //       icon: const Icon(Icons.add),
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: FutureBuilder(
            future: expensesProvider.getMonthlyExpenses
                .then((value) => widget.expenseData = value)
                .then((value) => incomeProvider.incomes)
                .then((value) {
              widget.incomeData = value;
            }),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(programSettings.tr_text["error"]);
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('loading');
              } else {
                print("Count ");
                return CreateMainList(
                  control: control,
                  expenseData: widget.expenseData,
                  incomeData: widget.incomeData,
                );
              }
            }),
      ),
      floatingActionButton: CustomFloatingBar(
        chart: widget,
      ),
    );
  }
}
