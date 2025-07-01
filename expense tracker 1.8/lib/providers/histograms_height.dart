import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/providers/expenses_category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

double computeMaxAmount({required Map<Category, double> categoryAmount}) {
  double maxAmount = 0;

  for (double amount in categoryAmount.values) {
    if (amount > maxAmount) {
      maxAmount = amount;
    }
  }
  return maxAmount;
}

double computeHistogramHeight({
  required maxHeight,
  required maxAmount,
  required amount,
}) {
  return (maxHeight / 100) * ((amount / maxAmount) * 100);
}

final histogramHeightProvider = Provider((ref) {
  final Map<Category, List<Expense>> expensesByCategory = ref.watch(
    expensesCategory,
  );

  final Map<Category, double> categoryAmount = {
    Category.food: expensesByCategory[Category.food]!.fold(
      0,
      (a, b) => a + b.amount,
    ),
    Category.leisure: expensesByCategory[Category.leisure]!.fold(
      0,
      (a, b) => a + b.amount,
    ),
    Category.travel: expensesByCategory[Category.travel]!.fold(
      0,
      (a, b) => a + b.amount,
    ),
    Category.work: expensesByCategory[Category.work]!.fold(
      0,
      (a, b) => a + b.amount,
    ),
  };

  final double maxAmount = computeMaxAmount(categoryAmount: categoryAmount);

  return {
    Category.food: computeHistogramHeight(
      maxHeight: 136,
      maxAmount: maxAmount,
      amount: categoryAmount[Category.food],
    ),
    Category.leisure: computeHistogramHeight(
      maxHeight: 136,
      maxAmount: maxAmount,
      amount: categoryAmount[Category.leisure],
    ),
    Category.travel: computeHistogramHeight(
      maxHeight: 136,
      maxAmount: maxAmount,
      amount: categoryAmount[Category.travel],
    ),
    Category.work: computeHistogramHeight(
      maxHeight: 136,
      maxAmount: maxAmount,
      amount: categoryAmount[Category.work],
    ),
  };
});
