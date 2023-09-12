import 'dart:math';

import 'package:expense_tracker_app/widgets/expenses.dart';
import 'package:flutter/material.dart';

final ColorScheme colorScheme = ColorScheme.fromSeed(
  seedColor: Colors.green,
);

void main() {
  runApp(
    MaterialApp(
      theme: _setTheme(),
      home: const Expenses(),
    ),
  );
}

ThemeData _setTheme() {
  return ThemeData().copyWith(
    useMaterial3: true,
    colorScheme: colorScheme,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.onPrimaryContainer,
      foregroundColor: colorScheme.primaryContainer,
    ),
    cardTheme: CardTheme(
      color: colorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primaryContainer,
      ),
    ),
    textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.normal,
            color: colorScheme.onSecondaryContainer,
            fontSize: 14,
          ),
        ),
  );
}
