import 'package:flutter/material.dart';

class ExpenseModel {
  final int id;
  final double amount;
  String? description = 'yok';
  final String type;
  final DateTime date;

  ExpenseModel({
    required this.id,
    required this.amount,
    required this.type,
    required this.date,
    description,
  });

  @override
  String toString() {
    return 'id : $id, amount : $amount, desription : $description , type : $type, time: ${date.toString()}';
  }
}
