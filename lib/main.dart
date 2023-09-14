import 'package:expense_tracker_app/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final ColorScheme colorSchemeLight = ColorScheme.fromSeed(
  seedColor: Colors.teal,
  brightness: Brightness.light,
);

final ColorScheme colorSchemeDark = ColorScheme.fromSeed(
  seedColor: Colors.teal,
  brightness: Brightness.dark,
);

void main() {
  //? Alternative way to be sure that the app is always in portrait mode
  /*WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (func) {
      runApp(
        MaterialApp(
          darkTheme: _setThemeDark(),
          theme: _setTheme(),
          home: const Expenses(),
        ),
      );
    },
  );*/
  runApp(
    MaterialApp(
      darkTheme: _setThemeDark(),
      theme: _setTheme(),
      home: const Expenses(),
    ),
  );
}

ThemeData _setTheme() {
  return ThemeData().copyWith(
    useMaterial3: true,
    colorScheme: colorSchemeLight,
    appBarTheme: AppBarTheme(
      backgroundColor: colorSchemeLight.onPrimaryContainer,
      foregroundColor: colorSchemeLight.primaryContainer,
    ),
    cardTheme: CardTheme(
      color: colorSchemeLight.secondaryContainer,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorSchemeLight.primaryContainer,
      ),
    ),
    textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorSchemeLight.onSecondaryContainer,
            fontSize: 16,
          ),
        ),
  );
}

ThemeData _setThemeDark() {
  return ThemeData.dark().copyWith(
    useMaterial3: true,
    colorScheme: colorSchemeDark,
    appBarTheme: AppBarTheme(
      backgroundColor: colorSchemeDark.onPrimaryContainer,
      foregroundColor: colorSchemeDark.primaryContainer,
    ),
    cardTheme: CardTheme(
      color: colorSchemeDark.secondaryContainer,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorSchemeDark.primaryContainer,
      ),
    ),
    textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorSchemeDark.onSecondaryContainer,
            fontSize: 16,
          ),
        ),
  );
}
