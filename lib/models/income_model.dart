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

  @override
  String toString() {
    // TODO: implement toString
    return "id : ${this.id} , desc :$description , income : $income, : date $date";
  }
}
