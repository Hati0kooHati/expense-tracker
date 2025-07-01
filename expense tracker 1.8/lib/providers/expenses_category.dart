import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/services/functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpensesCategoryNotifier
    extends StateNotifier<Map<Category, List<Expense>>> {
  ExpensesCategoryNotifier(this.ref)
    : super(computeExpenseCategoryAmountFn(ref: ref));

  final Ref ref;

  double computeTotalAmount() {
    double totalAmount = 0;

    for (List<Expense> expenseList in state.values) {
      totalAmount += expenseList.fold(0, (a, b) => a + b.amount);
    }
    return totalAmount;
  }
}

final expensesCategory = StateNotifierProvider(
  (ref) => ExpensesCategoryNotifier(ref),
);
