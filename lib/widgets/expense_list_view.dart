import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/providers/expense.dart';
import 'package:expense_tracker/widgets/expenses_card.dart';
import 'package:expense_tracker/widgets/histogram.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpensesListView extends ConsumerWidget {
  const ExpensesListView({super.key});

  void onDismissed({
    required Expense expense,
    required BuildContext context,
    required WidgetRef ref,
  }) {
    final int expenseIndex = ref.read(expenseProvider).indexOf(expense);

    ref.read(expenseProvider.notifier).deleteExpense(expense);

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text('expense removed'),
        action: SnackBarAction(
          label: 'cancel',
          onPressed: () {
            ref
                .read(expenseProvider.notifier)
                .insertExpense(expense, expenseIndex);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double width = MediaQuery.of(context).size.width;

    return width < 600
        ? ListView(
            children: [
              Histogram(),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: ref.watch(expenseProvider).length,
                itemBuilder: (context, index) {
                  final Expense currExpense = ref.read(expenseProvider)[index];

                  return Dismissible(
                    key: ValueKey(currExpense),
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
                      onDismissed(
                        expense: currExpense,
                        context: context,
                        ref: ref,
                      );
                    },
                    child: ExpenseCard(expense: currExpense),
                  );
                },
              ),
            ],
          )
        : Row(
            children: [
              Expanded(child: Histogram()),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: ref.read(expenseProvider).length,
                  itemBuilder: (context, index) {
                    final Expense currExpense = ref.read(
                      expenseProvider,
                    )[index];

                    return Dismissible(
                      key: ValueKey(currExpense),
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
                        onDismissed(
                          expense: currExpense,
                          context: context,
                          ref: ref,
                        );
                      },
                      child: ExpenseCard(expense: currExpense),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
