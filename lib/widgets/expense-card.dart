import 'package:flutter/material.dart';
import 'package:gelir_gider/methods/global_values.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/providers/program_settings_provider.dart';
import 'package:gelir_gider/widgets/custom_card.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

class ExpenseCard extends CustomCard {
  ExpenseCard({
    required String title,
    required double amount,
    required DateTime date,
    required int id,
    required Color color1,
    required Color color2,
  }) : super(
            title: title,
            amount: amount,
            date: date,
            id: id,
            color1: color1,
            color2: color2);
}
