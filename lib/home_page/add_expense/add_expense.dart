import 'package:flutter/material.dart';
import 'package:gelir_gider/expense_model.dart';
import 'package:gelir_gider/expense_provider.dart';
import 'package:provider/provider.dart';

class AddExpense extends StatelessWidget {
  Future<void> getDialog(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context, listen: false);
    final amount = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: const Text('Add Expense'),
              actions: [
                Form(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextFormField(
                      controller: amount,
                    ),
                    TextFormField(),
                    const Divider(),
                    ElevatedButton(
                      onPressed: () {
                        provider.addData(
                          ExpenseModel(
                            amount: double.parse(amount.text),
                            time: DateTime.now(),
                          ),
                        );
                      },
                      child: const Text('Add'),
                    ),
                  ],
                )),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
