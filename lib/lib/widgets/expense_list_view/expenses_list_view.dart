import 'package:flutter/material.dart';

import '../../data/expenses.dart';
import 'expense_card.dart';

import 'package:expense_tracker/widgets/expense_list_view/histogram_container.dart';

class ExpensesListView extends StatelessWidget {
  const ExpensesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HistogramContainer(),
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: expensesList.length,
          itemBuilder: (context, index) {
            return ExpenseCard(expensesList[index]);
          },
        ),
      ],
    );
  }
}
