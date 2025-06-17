import 'package:flutter/material.dart';

import 'package:expense_tracker/screens/expenses.dart';
import 'package:expense_tracker/screens/add_expense.dart';

class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});

  @override
  State<ExpenseTracker> createState() {
    return _ExpenseTrackerState();
  }
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  @override
  Widget build(context) {
    return MaterialApp(
      initialRoute: "/expensesScreen",
      routes: {
        "/expensesScreen": (context) => const Expenses(),
        "/addExpenseScreen": (context) => const AddExpense(),
      },

      debugShowCheckedModeBanner: false,
      home: Expenses(),
    );
  }
}

