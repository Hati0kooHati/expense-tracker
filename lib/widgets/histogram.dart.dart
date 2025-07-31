import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/providers/expenses_by_category.dart';
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

class Histogram extends ConsumerStatefulWidget {
  const Histogram({super.key});

  @override
  ConsumerState createState() => _HistogramState();
}

class _HistogramState extends ConsumerState<Histogram>
    with TickerProviderStateMixin {
  void onPressedHistogram({
    required Category category,
    required BuildContext context,
    required WidgetRef ref,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,

      context: context,

      builder: (BuildContext context) {
        final List<Expense> expenseListByCategory = ref.watch(
          expensesByCategory,
        )[category]!;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 600.0,
            child: ListView.builder(
              itemCount: expenseListByCategory.length,

              itemBuilder: (context, index) {
                return ExpenseCard(expense: expenseListByCategory[index]);
              },
            ),
          ),
        );
      },
    );
  }

  late final AnimationController _histogramBarAnimationController;

  @override
  void initState() {
    super.initState();

    _histogramBarAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    )..forward();
  }

  @override
  void dispose() {
    super.dispose();
    _histogramBarAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "total: ${ref.watch(expensesByCategory.notifier).totalCategoriesExpenseAmount.toStringAsFixed(2)}\$",
          style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
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
                          Text(
                            ref
                                .watch(expensesByCategory.notifier)
                                .getTotalCategoryExpense(histogram.key)
                                .toStringAsFixed(2),
                          ),
                          InkWell(
                            onTap: () {
                              onPressedHistogram(
                                category: histogram.key,
                                context: context,
                                ref: ref,
                              );
                            },

                            child: AnimatedBuilder(
                              animation: _histogramBarAnimationController,
                              builder: (context, child) {
                                return SizedBox(
                                  height: histogram.value,
                                  child: FractionallySizedBox(
                                    alignment: Alignment.bottomCenter,
                                    heightFactor:
                                        _histogramBarAnimationController.value,
                                    child: child,
                                  ),
                                );
                              },
                              child: Container(
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
