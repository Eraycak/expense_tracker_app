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
        background: Container(
          //*This will show icon at the left end when swiping from left to right
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: Theme.of(context).cardTheme.margin,
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 80,
            ),
          ),
        ),
        secondaryBackground: Container(
          //* This will show icon at the right end when swiping from right to left
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: Theme.of(context).cardTheme.margin,
          child: const Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 80,
            ),
          ),
        ),
        onDismissed: (direction) => onDismissExpense(expensesList[
            index]), //* this will remove the item from the list by swipe action
        child: ExpenseItem(
          expense: expensesList[index],
        ),
      ),
    );
  }
}
