import 'package:expense_tracker_app/enums/category.dart';
import 'package:expense_tracker_app/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/widgets/charts/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, //* This is to make the modal full screen
      builder: (contextBuilder) => NewExpense(
        onAddNewExpense: _addNewExpense,
      ),
    );
  }

  void _addNewExpense(Expense newExpense) {
    setState(
      () {
        _registeredExpenses.add(newExpense);
      },
    );
  }

  void _removeExpense(Expense expenseToRemove) {
    final int indexOfExpense = _registeredExpenses.indexOf(expenseToRemove);
    setState(() {
      _registeredExpenses.removeAt(indexOfExpense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense is removed!'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(
              () {
                _registeredExpenses.insert(
                  indexOfExpense,
                  expenseToRemove,
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expenses added yet!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expensesList: _registeredExpenses,
        onDismissExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseModal,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(
            expenses: _registeredExpenses,
          ),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
