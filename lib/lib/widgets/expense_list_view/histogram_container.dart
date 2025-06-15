import 'package:flutter/material.dart';

import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/data/expenses.dart';

class HistogramContainer extends StatelessWidget {
  HistogramContainer({super.key});

  final Map<String, Object> expensesTypeInfo = getExpensesInfo();

  late final double maxExpense = expensesTypeInfo["maxExpense"] as double;
  late final Map<Category, double> expensesTypeAmount =
      expensesTypeInfo["expensesTypeAmount"] as Map<Category, double>;

  late final totalExpensesAmount = computeTotalExpenseAmount(
    expensesTypeAmount,
  );

  final List<Category> expensesCategory = [
    Category.food,
    Category.leisure,
    Category.travel,
    Category.work,
  ];

  final List<IconData> categoryIcons = [
    Icons.fastfood_rounded,
    Icons.movie,
    Icons.airplanemode_active_rounded,
    Icons.work,
  ];

  late final List<Map<String, Object>> histogramsInfo = [
    for (int index = 0; index != expensesCategory.length; index++)
      {
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
      },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "total: ${totalExpensesAmount.toStringAsFixed(2)}\$",
          style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          height: 230.0,
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
                    ...histogramsInfo.map((histogramInfo) {
                      return Column(
                        children: [
                          Text(
                            "${(histogramInfo["expenseAmountPercent"] as double).toStringAsFixed(2)}%",
                            style: TextStyle(),
                          ),
                          Container(
                            height:
                                histogramInfo["histogramHeight"] as double,
                            width: 88.0,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(
                                255,
                                144,
                                115,
                                193,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                            ),
                          ),
                
                          Text(
                            "${(histogramInfo["expenseAmount"] as double).toStringAsFixed(2)}\$",
                          ),
                        ],
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
                      ...categoryIcons.map((icon) {
                        return Icon(
                          icon,
                          color: const Color.fromARGB(255, 144, 115, 193),
                          size: 27,
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
