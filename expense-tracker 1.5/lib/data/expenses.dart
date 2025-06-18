import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

final List<Expense> expensesList = [
  Expense(
    title: "cinema spiderman",
    notFormattedDate: DateTime.now(),
    amount: 19.99,
    category: Category.work,
  ),
  Expense(
    title: "title",
    notFormattedDate: DateTime.now(),
    amount: 15.69,
    category: Category.leisure,
  ),
  Expense(
    title: "travel to USA",
    notFormattedDate: DateTime(2025, 1, 1),
    amount: 24.69,
    category: Category.travel,
  ),

  Expense(
    title: "Dinner Lunch",
    notFormattedDate: DateTime(2025, 1, 1),
    amount: 24.69,
    category: Category.food,
  ),
];

final Map<Category, List<Expense>> expenseTypeSepareted = {
  Category.food: [],
  Category.leisure: [expensesList[1]],
  Category.travel: [expensesList[2]],
  Category.work: [expensesList[0]],
};

final List<Category> expensesCategory = [
  Category.food,
  Category.leisure,
  Category.travel,
  Category.work,
];

final List<IconData> categoryIcons = [
  Icons.fastfood_rounded,
  Icons.movie,
  Icons.flight_takeoff,
  Icons.work,
];

List<Map<String, Object>> histogramsInfo = [];

void updateHistogramInfo() {
  histogramsInfo.clear();

  for (int index = 0; index != expensesCategory.length; index++) {
    histogramsInfo.add({
      "category": expensesCategory[index],
      "expenseAmountPercent": computeExpenseTypePercent(
        expensesTypeAmount[expensesCategory[index]]!,
        totalExpensesAmount,
      ),
      "expenseAmount": expensesTypeAmount[expensesCategory[index]]!,
      "histogramHeight": computeContainerHeight(
        expensesTypeAmount[expensesCategory[index]]!,
        maxExpense,
        138,
      ),
    });
  }
}

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

Map<Category, List<Expense>> computeCategoryExpensesSepareted() {
  Map<Category, List<Expense>> categoryExpense = {
    Category.food: [],
    Category.leisure: [],
    Category.travel: [],
    Category.work: [],
  };

  for (Expense expense in expensesList) {
    categoryExpense[expense.category]!.add(expense);
  }

  return categoryExpense;
}
