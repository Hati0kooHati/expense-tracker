import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/providers/expenses_by_category.dart';
import 'package:expense_tracker/services/functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final histogramHeightProvider = Provider((ref) {
  final double maxAmount = ref
      .watch(expensesByCategory.notifier)
      .maxCategoryExpenseAmount;

  return {
    Category.food: computeHistogramHeightFn(
      maxHeight: 136,
      maxAmount: maxAmount,
      amount: ref
          .watch(expensesByCategory.notifier)
          .getTotalCategoryExpense(Category.food),
    ),
    Category.leisure: computeHistogramHeightFn(
      maxHeight: 136,
      maxAmount: maxAmount,
      amount: ref
          .watch(expensesByCategory.notifier)
          .getTotalCategoryExpense(Category.leisure),
    ),
    Category.travel: computeHistogramHeightFn(
      maxHeight: 136,
      maxAmount: maxAmount,
      amount: ref
          .watch(expensesByCategory.notifier)
          .getTotalCategoryExpense(Category.travel),
    ),
    Category.work: computeHistogramHeightFn(
      maxHeight: 136,
      maxAmount: maxAmount,
      amount: ref
          .watch(expensesByCategory.notifier)
          .getTotalCategoryExpense(Category.work),
    ),
  };
});
