import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gelir_gider/screens/home_screen.dart';
import './graphic.dart';

class CustomFloatingBar extends StatefulWidget {
  const CustomFloatingBar({Key? key, required this.chart}) : super(key: key);
  final HomeScreen chart;

  @override
  _CustomFloatingBarState createState() => _CustomFloatingBarState();
}

class _CustomFloatingBarState extends State<CustomFloatingBar> {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      child: const Icon(Icons.menu),
      overlayOpacity: 0,
      children: [
        SpeedDialChild(
          onTap: widget.chart.moveToGraph,
          label: 'Graphic',
          child: const Icon(Icons.grain_sharp),
        ),
        SpeedDialChild(
          label: 'Expenses',
          child: const Icon(Icons.attach_money_sharp),
          onTap: widget.chart.moveToExpenses,
        ),
        SpeedDialChild(
          label: 'Incomes',
          child: const Icon(Icons.money_off_sharp),
          onTap: widget.chart.moveToIncomes,
        ),
      ],
    );
  }
}
