import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class ExpenseCard extends StatelessWidget {
  ExpenseCard(this.expense, {super.key});

  final Expense expense;

  final Map<Category, IconData> expenseIcons = {
    Category.food: Icons.fastfood,
    Category.leisure: Icons.movie,
    Category.travel: Icons.airplanemode_active_rounded,
    Category.work: Icons.work,
  };

  @override
  Widget build(BuildContext context) {
    final String expenseDateString = expense.date;

    final DateTime expenseDateTime = DateTime(
      expense.notFormattedDate.year,
      expense.notFormattedDate.month,
      expense.notFormattedDate.day,
    );
    final DateTime dateTimeNow = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    final Duration dateTimeDifference = dateTimeNow.difference(expenseDateTime);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 9),

      borderOnForeground: true,
      elevation: 20.0,

      color: const Color.fromARGB(255, 219, 208, 238),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "\$${expense.amount.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: const Color.fromARGB(155, 0, 0, 0),
                    fontSize: 19,
                  ),
                ),

                const Spacer(),

                Icon(expenseIcons[expense.category], size: 28.0),

                const SizedBox(width: 10.0),

                Text(
                  dateTimeDifference < Duration(days: 1)
                      ? "today"
                      : dateTimeDifference <= Duration(days: 1)
                      ? "yestarday"
                      : dateTimeDifference <= Duration(days: 2)
                      ? "2 days ago"
                      : dateTimeDifference <= Duration(days: 3)
                      ? "3 days ago"
                      : dateTimeDifference <= Duration(days: 4)
                      ? "4 days ago"
                      : dateTimeDifference <= Duration(days: 5)
                      ? "5 days ago"
                      : dateTimeDifference <= Duration(days: 6)
                      ? "6 days ago"
                      : dateTimeDifference <= Duration(days: 7)
                      ? "week ago"
                      : expenseDateString,
                  style: TextStyle(fontSize: 17.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
