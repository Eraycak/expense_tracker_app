import 'package:expense_tracker_app/enums/category.dart';
import 'package:expense_tracker_app/models/expense.dart';

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  //* this will filter the expenses based on the category
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpensesAmount {
    return expenses.fold(
      0,
      (previousValue, expense) => previousValue + expense.amount,
    );

    //? this is the same as the above code
    /*double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;*/
  }
}
