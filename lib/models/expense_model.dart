import 'package:flutter/material.dart';

class ExpenseModel {
  final double amount;
  String description = "-";
  final String title;
  final DateTime date;

  ExpenseModel({
    required this.amount,
    required this.title,
    required this.date,
    description = '-',
  });

  @override
  String toString() {
    return 'amount : $amount, desription : $description , title : $title, time: ${date.toString()}';
  }

  Map<String, dynamic> get toJson => {
        'amount': amount,
        'desc': description,
        'title': title,
        'date': date.toString(),
      };
}
