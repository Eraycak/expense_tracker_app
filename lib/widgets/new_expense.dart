import 'package:flutter/material.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/enums/category.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddNewExpense});

  final void Function(Expense expense) onAddNewExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory;
  void _setSelectedCategory(Category? category) {
    if (category == null) {
      return;
    }
    setState(() {
      _selectedCategory = category;
    });
  }

  void _presentDatePicker() async {
    final currentDate = DateTime.now();
    final firstDate =
        DateTime(currentDate.year - 1, currentDate.month, currentDate.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: firstDate,
        lastDate: currentDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _closeModal(BuildContext context) {
    Navigator.pop(context);
  }

  void _submitExpenseData() {
    final double? enteredAmount = double.tryParse(_amountController.text);
    final bool isInvalidAmount = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        isInvalidAmount ||
        _selectedDate == null ||
        _selectedCategory == null) {
      showDialogOfPlatform();
      return;
    }
    widget.onAddNewExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory!),
    );
    _closeModal(context);
  }

  void showDialogOfPlatform() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (builderContext) => CupertinoAlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure valid title, amount, date, and category was entered.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(builderContext),
                child: const Text('Close')),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (builderContext) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure valid title, amount, date, and category was entered.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(builderContext),
                child: const Text('Close')),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (layoutBuilderContext, constraints) {
        final double maxWidth = constraints.maxWidth;
        final double maxHeight = constraints.maxHeight;
        final bool isLandscape = maxWidth > maxHeight;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                16,
                16,
                16,
                keyboardSpace + 16,
              ),
              child: Column(
                children: setLayout(isLandscape, context),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> setLayout(bool isLandscape, BuildContext context) {
    if (isLandscape) {
      return _buildLandscapeLayout(context);
    } else {
      return _buildPortraitLayout();
    }
  }

  List<Widget> _buildLandscapeLayout(BuildContext context) {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixText: '\$ ',
                label: Text('Amount'),
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          DropdownButton(
            value: _selectedCategory,
            items: _buildCategoryDropdownItems(),
            onChanged: (value) => _setSelectedCategory(value),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(_selectedDate == null
                    ? 'No date selected'
                    : 'Picked Date: ${dateFormatter.format(_selectedDate!)}'),
                IconButton(
                  onPressed: _presentDatePicker,
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 24),
      Row(
        children: [
          const Spacer(),
          TextButton(
            onPressed: () => _closeModal(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _submitExpenseData,
            child: const Text('Save Expense'),
          ),
        ],
      ),
    ];
  }

  List<Widget> _buildPortraitLayout() {
    return [
      TextField(
        controller: _titleController,
        maxLength: 50,
        decoration: const InputDecoration(
          label: Text('Title'),
        ),
      ),
      Row(
        children: [
          Expanded(
            child: TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixText: '\$ ',
                label: Text('Amount'),
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(_selectedDate == null
                    ? 'No date selected'
                    : 'Picked Date: ${dateFormatter.format(_selectedDate!)}'),
                IconButton(
                  onPressed: _presentDatePicker,
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),
          ),
        ],
      ),
      Row(
        children: [
          DropdownButton(
            value: _selectedCategory,
            items: _buildCategoryDropdownItems(),
            onChanged: (value) => _setSelectedCategory(value),
          ),
          const Spacer(),
          TextButton(
            onPressed: () => _closeModal(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _submitExpenseData,
            child: const Text('Save Expense'),
          ),
        ],
      ),
    ];
  }

  List<DropdownMenuItem<Category>> _buildCategoryDropdownItems() {
    return Category.values.map((category) {
      return DropdownMenuItem(
        value: category,
        child: Text(category.name.toUpperCase()),
      );
    }).toList();
  }
}
