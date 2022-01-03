import 'package:flutter/material.dart';

class ExpenseModel {
  final double amount;
  final String type;
  final DateTime time;

  ExpenseModel({
    required this.amount,
    required this.type,
    required this.time,
  });
}
