import 'package:expense_tracker/models/expense.dart';

Map<Category, List<Expense>> sortExpensesByCategory({
  required List<Expense> expensesList,
}) {
  final Map<Category, List<Expense>> expensesByCategory = {
    Category.food: [],
    Category.leisure: [],
    Category.travel: [],
    Category.work: [],
  };

  for (Expense expense in expensesList) {
    expensesByCategory[expense.category]!.add(expense);

    expensesByCategory[expense.category]!.sort(
      (expense1, expense2) => expense2.date.compareTo(expense1.date),
    );
  }

  return expensesByCategory;
}

double computeHistogramHeightFn({
  required maxHeight,
  required maxAmount,
  required amount,
}) {
  return (maxHeight / 100) * ((amount / maxAmount) * 100);
}
