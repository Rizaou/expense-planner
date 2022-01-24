import 'package:flutter/material.dart';
import 'package:gelir_gider/models/income_model.dart';
import 'package:gelir_gider/providers/income_provider.dart';
import 'package:provider/provider.dart';

class AddIncome extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  Future<void> getDialog(BuildContext context) {
    final incomeProvider = Provider.of<IncomeProvider>(context, listen: false);
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              content: const Text('Add Income'),
              actions: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Form(
                      child: Column(
                    children: [
                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(label: Text('Title')),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: amountController,
                        decoration:
                            const InputDecoration(label: Text('Amount')),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          incomeProvider.addIncome(IncomeModel(
                              id: 0,
                              income: double.parse(
                                  amountController.text.toString()),
                              date: DateTime.now()));
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
