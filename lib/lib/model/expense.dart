import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { food, leisure, work, travel }

class Expense {
  Expense({
    required this.title,
    required this.date,
    required this.amount,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final DateTime date;
  final double amount;
  final Category category;
}
