import 'package:flutter/material.dart';
import 'package:gelir_gider/methods/global_values.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/providers/program_settings_provider.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

class CustomCard extends StatelessWidget {
  final int id;
  final String title;
  final double amount;
  final DateTime date;
  final Color color1;
  final Color color2;

  const CustomCard({
    Key? key,
    required this.title,
    required this.amount,
    required this.date,
    required this.id,
    required this.color1,
    required this.color2,
  }) : super(key: key);

  String _checkTag() {
    //TODO: Check if the input lenght higher than X value, then do some operations.

    if (title.length > 10) {
      String yeni = title.substring(0, 7);

      return (yeni + '...');
    } else {
      return title;
    }
  }

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    return Container(
      margin: const EdgeInsets.all(global_horizontal_padding),
      child: Dismissible(
        onDismissed: (direction) => expenseProvider.deleteData(id),
        key: Key(id.toString()),
        background: Container(
          color: secondaryColor,
          margin: EdgeInsets.symmetric(vertical: 8),
        ),
        direction: DismissDirection.endToStart,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(global_card_corner_low),
            gradient: LinearGradient(
              colors: [
                color1,
                color2,
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
          height: global_card_height_px,
          child: Row(
            children: [
              Container(
                //alignment: Alignment.center,
                padding: const EdgeInsets.only(
                  left: global_horizontal_padding * 2,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      '$amount',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy').format(date),
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(global_horizontal_padding),
                //alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        title, //_checkTag(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
