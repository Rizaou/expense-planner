import 'package:flutter/material.dart';

class ExpenseModel {
  final double amount;
  String? description = 'yok';
  final String type;
  final DateTime date;

  ExpenseModel({
    required this.amount,
    required this.type,
    required this.date,
    description,
  });

  @override
  String toString() {
    return 'amount : $amount, desription : $description , type : $type, time: ${date.toString()}';
  }
}
