import 'package:flutter/material.dart';

import 'package:expense_tracker/screens/expenses.dart';
import 'package:expense_tracker/screens/add_expense.dart';

ColorScheme kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 114, 49, 199),
);

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
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.onPrimaryContainer,
        ),
      ),
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
