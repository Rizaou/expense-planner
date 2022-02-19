import 'package:flutter/material.dart';

class CustomBar extends StatelessWidget {
  CustomBar({
    Key? key,
    required this.maxValue,
    required this.currentValue,
  }) : super(key: key);

  final double maxValue;
  final double currentValue;

  double get _calculateRatio {
    if (currentValue >= maxValue) {
      return 1.0;
    } else if (maxValue == 0 || currentValue == 0) {
      return 0.0;
    }

    return currentValue / maxValue;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.all(1),

          //width: MediaQuery.of(context).size.width,
          height: 16,
          child: FractionallySizedBox(
            child: Container(
              decoration: BoxDecoration(
                // gradient: LinearGradient(
                //   tileMode: TileMode.decal,
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [
                //     Theme.of(context).primaryColor,
                //     Theme.of(context).primaryColor,
                //   ],
                // ),
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(
                  100,
                ),
              ),
            ),
            alignment: Alignment.centerLeft,
            widthFactor: _calculateRatio,
          ),

          // LayoutBuilder(
          //   builder: (context, constraints) {
          //     return Stack(
          //       alignment: Alignment.centerLeft,
          //       children: [
          //         Container(
          //           //margin: EdgeInsets.all(global_horizontal_padding),
          //           //height: 23,
          //           decoration: BoxDecoration(
          //               color: Colors.grey,
          //               borderRadius: BorderRadius.circular(100)),
          //         ),
          //         Positioned(
          //           left: calculateRatio(
          //               maxWidth: constraints.maxWidth,
          //               totalExpenses: expenseProvider.getSumOfExpenses(),
          //               totalIncomes: incomeProvider.totalIncome),
          //           child: Container(
          //             decoration: BoxDecoration(
          //               color: Colors.black,
          //               borderRadius: BorderRadius.circular(20),
          //             ),
          //             height: 10,
          //             width: 10,
          //           ),
          //         ),
          //       ],
          //     );
          //   },
          // ),
        ),
      ],
    );
  }
}
