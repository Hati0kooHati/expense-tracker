import 'package:expense_tracker/data/expenses.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _amountController;

  DateTime pickedDate = DateTime.now();
  String dropdownValue = "LEISURE";

  Map<String, Category> stringToCategory = {
    "FOOD": Category.food,
    "LEISURE": Category.leisure,
    "TRAVEL": Category.travel,
    "WORK": Category.work,
  };

  List<String> dropdownItems = ["FOOD", "LEISURE", "TRAVEL", "WORK"];

  @override
  void dispose() {
    super.dispose();

    _titleController.clear();
    _amountController.clear();
  }

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController();
    _amountController = TextEditingController();
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(label: Text("Title")),

                maxLength: 50,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter title";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15.0),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        label: Text("Amount"),
                        prefixText: "\$",
                        prefixIconColor: Colors.grey,
                      ),

                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter price";
                        }

                        return null;
                      },
                    ),
                  ),

                  const SizedBox(width: 100.0),

                  Row(
                    children: [
                      Text(
                        pickedDate.toString().substring(0, 11),
                        style: TextStyle(fontSize: 16.0),
                      ),
                      IconButton(
                        onPressed: _selectDate,
                        icon: Icon(Icons.calendar_month, size: 30.0),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20.0),

              Row(
                children: [
                  DropdownButton(
                    value: dropdownValue,
                    items:
                        dropdownItems.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value as String;
                      });
                    },
                  ),

                  Expanded(child: SizedBox()),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/expensesScreen");
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.all(19.0),
                    ),
                    child: Text("Cancel", style: TextStyle(fontSize: 16)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        expensesList.add(
                          Expense(
                            title: _titleController.text,
                            date: pickedDate,
                            amount: double.parse(_amountController.text),
                            category: stringToCategory[dropdownValue]!,
                          ),
                        );
                      });

                      Navigator.pushNamed(context, "/expensesScreen");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(128, 204, 185, 231),
                      shadowColor: Colors.transparent,
                      minimumSize: Size(90.0, 55.0),
                    ),
                    child: Text(
                      "Save Expenses",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        pickedDate = picked;
      });
    }
  }
}
