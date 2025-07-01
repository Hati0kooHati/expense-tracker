import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/providers/expense.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Map<Category, List<Expense>> computeExpenseCategoryAmountFn({
  required Ref ref,
}) {
  final List<Expense> expensesList = ref.watch(expenseProvider);

  final Map<Category, List<Expense>> expensesByCategory = {
    Category.food: [],
    Category.leisure: [],
    Category.travel: [],
    Category.work: [],
  };

  for (Expense expense in expensesList) {
    if (!expensesByCategory[expense.category]!.contains(expense)) {
      expensesByCategory[expense.category]!.add(expense);

      expensesByCategory[expense.category]!.sort(
        (expense1, expense2) => expense2.date.compareTo(expense1.date),
      );
    }
  }

  return expensesByCategory;
}
