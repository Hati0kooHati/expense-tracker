import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/providers/expenses_category.dart';
import 'package:expense_tracker/providers/histograms_height.dart';
import 'package:expense_tracker/widgets/expenses_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<IconData> kCategoryIcons = [
  Icons.fastfood,
  Icons.movie,
  Icons.airplane_ticket_outlined,
  Icons.work,
];

class HistogramContainer extends ConsumerWidget {
  const HistogramContainer({super.key});

  void onPressedHistogram({
    required Category category,
    required BuildContext context,
    required WidgetRef ref,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,

      context: context,

      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 600.0,
            child: ListView.builder(
              itemCount: ref.watch(expensesCategory)[category]!.length,

              itemBuilder: (context, index) {
                return ExpenseCard(
                  expense: ref.watch(expensesCategory)[category]![index],
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(
          "total: ${ref.watch(expensesCategory.notifier).computeTotalAmount().toStringAsFixed(2)}\$",
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
                    ...ref.watch(histogramHeightProvider).entries.map((
                      histogram,
                    ) {
                      return Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              onPressedHistogram(
                                category: histogram.key,
                                context: context,
                                ref: ref,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(0),
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              minimumSize: Size(0, 0),
                            ),
                            child: Container(
                              height: histogram.value,
                              width: 88.0,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 144, 115, 193),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                              ),
                            ),
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
                      ...kCategoryIcons.map((icon) {
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
