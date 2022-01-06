import 'package:flutter/material.dart';

class ExpenseModel {
  final double amount;
  late String description;
  final String type;
  final DateTime date;

  ExpenseModel({
    required this.amount,
    required this.type,
    required this.date,
    description = '',
  });
}
