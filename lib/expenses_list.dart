import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expensesList;
  const ExpensesList({super.key, required this.expensesList});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (context, index) => Text(expensesList[index].title),
    );
  }
}
