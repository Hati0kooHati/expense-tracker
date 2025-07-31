import 'package:expense_tracker/providers/expense.dart';
import 'package:expense_tracker/screens/add_expense.dart';
import 'package:expense_tracker/widgets/expense_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_ri';

class ExpensesScreen extends ConsumerWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Widget mainContent;

    if (ref.watch(expenseProvider).isNotEmpty) {
      mainContent = ExpensesListView();
    } else {
      mainContent = Center(child: Text("No expenses"));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AddExpense()),
              );
            },
            icon: Icon(Icons.add, size: 35.0, color: Colors.white),
          ),

          const SizedBox(width: 10.0),
        ],
      ),

      body: mainContent,
    );
  }
}
