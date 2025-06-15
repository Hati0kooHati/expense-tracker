import 'package:expense_tracker/model/expense.dart';

final List<Expense> expensesList = [
  Expense(
    title: "cinema spiderman",
    date: DateTime.now(),
    amount: 19.99,
    category: Category.work,
  ),
  Expense(
    title: "title",
    date: DateTime.now(),
    amount: 15.69,
    category: Category.leisure,
  ),
  Expense(
    title: "travel to USA",
    date: DateTime(2025, 1, 1),
    amount: 24.69,
    category: Category.food,
  ),
];

Map<String, Object> getExpensesInfo() {
  double maxExpense = 0;

  Map<Category, double> expensesTypeAmount = {
    Category.food: 0,
    Category.leisure: 0,
    Category.travel: 0,
    Category.work: 0,
  };

  for (Expense expense in expensesList) {
    expensesTypeAmount[expense.category] =
        (expensesTypeAmount[expense.category] ?? 0) + expense.amount;
  }

  for (double amount in expensesTypeAmount.values) {
    if (amount > maxExpense) {
      maxExpense = amount;
    }
  }

  return {"maxExpense": maxExpense, "expensesTypeAmount": expensesTypeAmount};
}

double computeContainerHeight(
  double amount,
  double maxExpense,
  double maxHeight,
) {
  final double percentFromMaxHeight = (amount / maxExpense) * 100;

  return (maxHeight / 100) * percentFromMaxHeight;
}

double computeExpenseTypePercent(double expenseAmount, totalExpensesAmount) {
  return (expenseAmount / totalExpensesAmount) * 100;
}

double computeTotalExpenseAmount(Map<Category, double> expensesTypeAmount) {
  double totalExpensesAmount = 0;

  for (double expenseAmount in expensesTypeAmount.values) {
    totalExpensesAmount += expenseAmount;
  }

  return totalExpensesAmount;
}
