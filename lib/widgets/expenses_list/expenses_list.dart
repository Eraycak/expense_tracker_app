import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expensesList,
    required this.onDismissExpense,
  });
  final List<Expense> expensesList;
  final void Function(Expense expense) onDismissExpense;
  @override
  Widget build(BuildContext context) {
    //* show the list of expenses in a list view widget for hiding not visible items
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expensesList[index]),
        onDismissed: (direction) => onDismissExpense(expensesList[
            index]), //* this will remove the item from the list by swipe action
        child: ExpenseItem(
          expense: expensesList[index],
        ),
      ),
    );
  }
}
