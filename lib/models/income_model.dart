class IncomeModel {
  final int id;
  String description = '-';
  final double income;
  final DateTime date;

  IncomeModel({
    required this.id,
    this.description = '-',
    required this.income,
    required this.date,
  });

  Map<String, dynamic> get toJson => {
        'income': income,
        'desc': description,
        'date': date.toString(),
      };
}
