import 'package:expense_tracker/models/expense.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseNotifier extends StateNotifier<List<Expense>> {
  ExpenseNotifier()
    : super([
        Expense(
          title: "Gas for Car",
          amount: 40.00,
          category: Category.travel,
          date: DateTime(2025, 1, 20),
        ),
        Expense(
          title: "Streaming Subscription",
          amount: 11.99,
          category: Category.leisure,
          date: DateTime(2025, 1, 19),
        ),
        Expense(
          title: "Coworking Space",
          amount: 100.00,
          category: Category.work,
          date: DateTime(2025, 1, 18),
        ),
        Expense(
          title: "Weekly Groceries",
          amount: 85.40,
          category: Category.food,
          date: DateTime(2025, 1, 17),
        ),
        Expense(
          title: "Train Ticket",
          amount: 22.10,
          category: Category.travel,
          date: DateTime(2025, 1, 16),
        ),
        Expense(
          title: "Museum Visit",
          amount: 14.25,
          category: Category.leisure,
          date: DateTime(2025, 1, 15),
        ),
        Expense(
          title: "Freelance Tools",
          amount: 60.00,
          category: Category.work,
          date: DateTime(2025, 1, 14),
        ),
        Expense(
          title: "Dinner Out",
          amount: 30.50,
          category: Category.food,
          date: DateTime(2025, 1, 13),
        ),
        Expense(
          title: "Concert Ticket",
          amount: 45.00,
          category: Category.leisure,
          date: DateTime(2025, 1, 12),
        ),
        Expense(
          title: "Flight to NY",
          amount: 150.00,
          category: Category.travel,
          date: DateTime(2025, 1, 10),
        ),
        Expense(
          title: "Office Supplies",
          amount: 24.30,
          category: Category.work,
          date: DateTime(2025, 1, 8),
        ),
        Expense(
          title: "Lunch at Cafe",
          amount: 9.99,
          category: Category.food,
          date: DateTime(2025, 1, 7),
        ),
        Expense(
          title: "Uber Ride",
          amount: 18.75,
          category: Category.travel,
          date: DateTime(2025, 1, 5),
        ),
        Expense(
          title: "Cinema Ticket",
          amount: 12.00,
          category: Category.leisure,
          date: DateTime(2025, 1, 3),
        ),
        Expense(
          title: "Apple",
          amount: 2.50,
          category: Category.food,
          date: DateTime(2025, 1, 1),
        ),
      ]);

  void insertExpense(Expense expense, int insertIndex) {
    final List<Expense> sortedState = [...state];
    sortedState.insert(insertIndex, expense);

    sortedState.sort(
      (expense1, expense2) => expense2.date.compareTo(expense1.date),
    );

    state = sortedState;
  }

  void deleteExpense(Expense expense) {
    state = state.where((exp) => exp.id != expense.id).toList();
  }
}

final expenseProvider = StateNotifierProvider((ref) => ExpenseNotifier());
