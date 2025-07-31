import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final dateFormater = DateFormat("dd MM yyyy");

final Uuid uid = Uuid();

enum Category { food, leisure, work, travel }

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  }) : id = uid.v4();

  final String id;
  final String title;
  final double amount;
  final Category category;
  final DateTime date;

  String getDaysSinceCreation() {
    final int dayDifferences = DateTime.now().difference(date).inDays;

    if (dayDifferences == 0) {
      return "today";
    } else if (dayDifferences == 1) {
      return "yestarday";
    } else if (dayDifferences == 7) {
      return ("week ago");
    } else {
      return date.toString().split(" ")[0].replaceAll("-", " ");
    }
  }
}
