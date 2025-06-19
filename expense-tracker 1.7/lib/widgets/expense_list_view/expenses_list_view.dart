import 'package:flutter/material.dart';

import '../../data/expenses.dart';
import 'expense_card.dart';
import 'package:expense_tracker/model/expense.dart';

import 'package:expense_tracker/widgets/expense_list_view/histogram_container.dart';

class ExpensesListView extends StatefulWidget {
  const ExpensesListView({super.key, required this.onExpenseRemoved});

  final void Function() onExpenseRemoved;

  @override
  State<ExpensesListView> createState() => _ExpensesListViewState();
}

class _ExpensesListViewState extends State<ExpensesListView> {
  void onDismissed(Expense expense) {
    final Category category = expense.category;
    final int expenseIndex = expensesList.indexOf(expense);

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text('expense removed'),
        action: SnackBarAction(
          label: 'cancel',
          onPressed: () {
            setState(() {
              expensesList.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );

    setState(() {
      expensesList.remove(expense);
      expenseTypeSepareted[category]!.remove(expense);

      widget.onExpenseRemoved();
    });
  }

  @override
  Widget build(BuildContext context) {
    expensesList.sort(
      (a, b) => b.notFormattedDate.compareTo(a.notFormattedDate),
    );

    final double width = MediaQuery.of(context).size.width;

    return width < 600
        ? Column(
          // scrollDirection: Axis.horizontal,
          children: [
            HistogramContainer(),
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: expensesList.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(expensesList[index]),
                  background: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.red,
                    ),
                    margin: EdgeInsets.all(8),
            
                    child: Row(
                      children: [
                        const Spacer(),
                        Icon(Icons.delete, color: Colors.white, size: 40.0),
                        const SizedBox(width: 40.0),
                      ],
                    ),
                  ),
            
                  onDismissed: (direction) {
                    onDismissed(expensesList[index]);
                  },
                  child: ExpenseCard(expensesList[index]),
                );
              },
            ),
          ],
        )
        : Row(
          // scrollDirection: Axis.horizontal,
          children: [
            Expanded(child: HistogramContainer()),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: expensesList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: ValueKey(expensesList[index]),
                    background: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.red,
                      ),
                      margin: EdgeInsets.all(8),

                      child: Row(
                        children: [
                          const Spacer(),
                          Icon(Icons.delete, color: Colors.white, size: 40.0),
                          const SizedBox(width: 40.0),
                        ],
                      ),
                    ),

                    onDismissed: (direction) {
                      onDismissed(expensesList[index]);
                    },
                    child: ExpenseCard(expensesList[index]),
                  );
                },
              ),
            ),
          ],
        );
  }
}
