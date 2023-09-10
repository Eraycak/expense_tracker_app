import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expensesList;
  const ExpensesList({super.key, required this.expensesList});
  @override
  Widget build(BuildContext context) {
    //* show the list of expenses in a list view widget for hiding not visible items
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (context, index) => ExpenseItem(
        expense: expensesList[index],
      ),
    );
  }
}
