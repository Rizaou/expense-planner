import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ExpenseCard extends StatelessWidget {
  final String tag;
  final double amount;
  final DateTime time;
  const ExpenseCard(
      {Key? key, required this.tag, required this.amount, required this.time})
      : super(key: key);

  String _checkTag() {
    if (tag.length > 10) {
      String yeni = tag.substring(0, 7);

      return (yeni + '...');
    } else {
      return tag;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Card(
        elevation: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.card_travel_outlined),
                Container(
                  alignment: Alignment.center,
                  width: 70,
                  child: Text(_checkTag()),
                ),
              ],
            ),
            Container(
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 10),
                  Text('$amount'),
                  Text(
                    DateFormat('dd/MM/yyyy').format(time),
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
