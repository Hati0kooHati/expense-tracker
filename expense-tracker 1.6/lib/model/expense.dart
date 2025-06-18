import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

Map<String, String> monthIndexesToName = {
  '01': 'January',
  '02': 'February',
  '03': 'March',
  '04': 'April',
  '05': 'May',
  '06': 'June',
  '07': 'July',
  '08': 'August',
  '09': 'September',
  '10': 'October',
  '11': 'November',
  '12': 'December',
};

enum Category { food, leisure, work, travel }

var formatter = DateFormat("d MM yyyy");

class Expense {
  Expense({
    required this.title,
    required this.notFormattedDate,
    required this.amount,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final DateTime notFormattedDate;
  final double amount;
  final Category category;

  String get date {
    String formattedDate = formatter.format(notFormattedDate);

    String monthIndex = formattedDate.split(" ")[1];

    return formattedDate.replaceFirst(
      monthIndex,
      monthIndexesToName[monthIndex]!,
    );
  }
}
