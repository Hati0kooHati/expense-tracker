import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/data/expenses.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  @override
  Widget build(context) {
    final Map<String, Object> expensesTypeInfo = getExpensesInfo();

    late final double maxExpense = expensesTypeInfo["maxExpense"] as double;
    late final Map<Category, double> expensesTypeAmount =
        expensesTypeInfo["expensesTypeAmount"] as Map<Category, double>;

    late final List<double> containersHeight = [
      computeContainerHeight(
        expensesTypeAmount[Category.food]!,
        maxExpense,
        138,
      ),

      computeContainerHeight(
        expensesTypeAmount[Category.leisure]!,
        maxExpense,
        138,
      ),

      computeContainerHeight(
        expensesTypeAmount[Category.travel]!,
        maxExpense,
        138,
      ),

      computeContainerHeight(
        expensesTypeAmount[Category.work]!,
        maxExpense,
        138,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: const Color.fromARGB(255, 28, 8, 99),
        actions: [
          Text(
            "Expense Tracker",
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),

          const SizedBox(width: 230.0),

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

      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            height: 190.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color.fromARGB(255, 252, 252, 252),
                  const Color.fromARGB(255, 202, 185, 231),
                ],
              ),
            ),

            child: Padding(
              padding: const EdgeInsets.only(
                right: 8,
                left: 8,
                bottom: 15,
                top: 0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ...containersHeight.map((height) {
                        return Container(
                          height: height,
                          width: 88.0,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 144, 115, 193),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),

                  SizedBox(height: 10.0),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.fastfood_rounded,
                          color: const Color.fromARGB(255, 144, 115, 193),
                          size: 27,
                        ),
                        Icon(
                          Icons.movie,
                          color: const Color.fromARGB(255, 144, 115, 193),
                          size: 27,
                        ),
                        Icon(
                          Icons.airplanemode_active_rounded,
                          color: const Color.fromARGB(255, 144, 115, 193),
                          size: 27,
                        ),
                        Icon(
                          Icons.work,
                          color: const Color.fromARGB(255, 144, 115, 193),
                          size: 27,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: expensesList.length,
              itemBuilder: (context, index) {
                final expense = expensesList[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 9),

                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 219, 208, 238),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),

                  height: 100.0,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expense.title,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10.0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${expensesList[index].amount}\$",
                              style: TextStyle(
                                color: const Color.fromARGB(155, 0, 0, 0),
                                fontSize: 19,
                              ),
                            ),

                            Expanded(child: SizedBox()),

                            Icon(
                              expense.category == Category.food
                                  ? Icons.fastfood_rounded
                                  : expense.category == Category.leisure
                                  ? Icons.movie
                                  : expense.category == Category.travel
                                  ? Icons.airplanemode_active_rounded
                                  : Icons.work,
                              size: 28.0,
                            ),

                            const SizedBox(width: 10.0),

                            Text(
                              "${expense.date.toString().substring(0, 11)}",
                              style: TextStyle(fontSize: 17.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
