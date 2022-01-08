class IncomeModel {
  final int id;
  String? description = 'yok';
  final double income;
  final DateTime date;

  IncomeModel({
    required this.id,
    this.description,
    required this.income,
    required this.date,
  });
}
