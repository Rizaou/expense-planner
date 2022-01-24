import 'package:flutter/material.dart';
import 'package:gelir_gider/models/expense_model.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:provider/provider.dart';

class AddExpense extends StatelessWidget {
  Future<void> getDialog(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context, listen: false);
    final amount = TextEditingController();
    final type = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: const Text('Add Expense'),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: amount,
                        decoration: InputDecoration(
                          label: Text('Amount'),
                        ),
                      ),
                      TextFormField(
                        controller: type,
                        decoration: InputDecoration(
                          label: Text('Type'),
                        ),
                      ),
                      const Divider(),
                      ElevatedButton(
                        onPressed: () {
                          if (!amount.text.isEmpty) {
                            print(
                                "Amount : ${amount.text} ,title : ${type.text} , time : ${DateTime.now()}");
                            provider.addData(
                              ExpenseModel(
                                amount: double.parse(amount.text),
                                title: type.text,
                                date: DateTime.now(),
                              ),
                            );
                          }
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  )),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
