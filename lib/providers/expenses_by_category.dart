import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/providers/expense.dart';
import 'package:expense_tracker/services/functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpensesByCategoryNotifier
    extends StateNotifier<Map<Category, List<Expense>>> {
  ExpensesByCategoryNotifier(this.ref)
    : super(sortExpensesByCategory(expensesList: ref.watch(expenseProvider)));

  final Ref ref;

  double getTotalCategoryExpense(Category category) {
    return state[category]!.fold(0.0, (a, b) => a + b.amount);
  }

  double get totalCategoriesExpenseAmount {
    double totalAmount = 0;

    for (List<Expense> expenseList in state.values) {
      totalAmount += expenseList.fold(0, (a, b) => a + b.amount);
    }

    return totalAmount;
  }

  double get maxCategoryExpenseAmount {
    double maxCategoryExpenseAmount = 0;

    for (Category category in state.keys) {
      final double totalCategoryExpense = getTotalCategoryExpense(category);

      if (totalCategoryExpense > maxCategoryExpenseAmount) {
        maxCategoryExpenseAmount = totalCategoryExpense;
      }
    }

    return maxCategoryExpenseAmount;
  }
}

final expensesByCategory = StateNotifierProvider(
  (ref) => ExpensesByCategoryNotifier(ref),
);
