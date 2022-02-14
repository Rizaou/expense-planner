import 'package:flutter/material.dart';

class ExpenseModel {
  final int id;
  final double amount;
  String description = "-";
  final String title;
  final DateTime date;

  ExpenseModel({
    this.id = 0,
    required this.amount,
    required this.title,
    required this.date,
    description = '-',
  });

  @override
  String toString() {
    return 'id : $id' +
        'amount : $amount, desription : $description , title : $title, time: ${date.toString()}';
  }

  Map<String, dynamic> get toJson => {
        'id': id,
        'amount': amount,
        'desc': description,
        'title': title,
        'date': date.toString(),
      };
}
