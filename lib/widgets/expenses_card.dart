import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  ExpenseCard({super.key, required this.expense});

  final Expense expense;

  final Map<Category, IconData> expenseIcons = {
    Category.food: Icons.fastfood,
    Category.leisure: Icons.movie,
    Category.travel: Icons.airplanemode_active_rounded,
    Category.work: Icons.work,
  };

  @override
  Widget build(BuildContext context) {
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
                  expense.getDaysSinceCreation(),
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
