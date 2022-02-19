import 'package:flutter/material.dart';
import 'package:gelir_gider/database/database_provider_incomes.dart';
import 'package:gelir_gider/methods/global_values.dart';
import 'package:gelir_gider/providers/income_provider.dart';
import 'package:provider/provider.dart';

class IncomeCard extends StatelessWidget {
  const IncomeCard(
      {Key? key, required this.id, required this.title, required this.amount})
      : super(key: key);
  final int id;
  final String title;
  final double amount;

  @override
  Widget build(BuildContext context) {
    final incomeProvider = Provider.of<IncomeProvider>(context);

    return Container(
        // margin: const EdgeInsets.all(global_horizontal_padding),
        // child: Dismissible(
        //   key: ValueKey(id),
        //   onDismissed: (direction) => incomeProvider.deleteData(id),
        //   child: Container(
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(global_card_corner_low),
        //       gradient: LinearGradient(
        //         colors: [
        //           cardColor,
        //           Colors.white,
        //         ],
        //         begin: Alignment.topLeft,
        //         end: Alignment.topRight,
        //       ),
        //     ),
        //     alignment: Alignment.center,
        //     height: global_card_height_px,
        //     width: double.infinity,
        //     child: Row(
        //       //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         Container(
        //           child: Flexible(child: Text('${title}')),
        //           padding: EdgeInsets.only(
        //               left: global_horizontal_padding * 2,
        //               top: global_horizontal_padding),
        //         ),
        //         Spacer(),
        //         Container(
        //           child: Row(
        //             children: [
        //               Flexible(
        //                   child: Text(
        //                 '${amount}',
        //                 textAlign: TextAlign.center,
        //               )),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}
