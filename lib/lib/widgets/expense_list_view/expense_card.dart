import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard(this.expense, {super.key});

  final Expense expense;

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

                Icon(
                  expense.category == Category.food
                      ? Icons.fastfood_rounded
                      : expense.category == Category.leisure
                      ? Icons.movie
                      : expense.category == Category.travel
                      ? Icons.airplanemode_active_rounded
                      : Icons.work,
                  size: 28.0,
                ),

                const SizedBox(width: 10.0),

                Text(
                  expense.date.toString().substring(0, 11),
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
