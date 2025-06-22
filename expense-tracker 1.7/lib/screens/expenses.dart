import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expense_list_view/expenses_list_view.dart';
import 'package:expense_tracker/data/expenses.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  void onExpenseRemoved() {
    setState(() {});
  }

  @override
  Widget build(context) {
    Widget mainContent = Center(child: Text("No expenses"));
    if (expensesList.isNotEmpty) {
      mainContent = ExpensesListView(onExpenseRemoved: onExpenseRemoved);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80.0,
        backgroundColor: const Color.fromARGB(255, 28, 8, 99),
        title: Text(
          "Expense Tracker",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              Navigator.pushNamed(context, "/addExpenseScreen");
            },
            icon: Icon(Icons.add, size: 35.0, color: Colors.white),
          ),

          const SizedBox(width: 10.0),
        ],
      ),

      body: SafeArea(child: mainContent),
    );
  }
}
