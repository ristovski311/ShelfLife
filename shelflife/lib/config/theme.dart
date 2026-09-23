import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData get getBaseTheme {
  return generateTheme(
    primary: Colors.deepOrange,
    secondary: Colors.red,
    tertiary: Colors.orange,
    primaryAccent: Colors.deepOrangeAccent,
    secondaryAccent: Colors.redAccent,
    tertiaryAccent: Colors.orangeAccent,
    textOnPrimary: Colors.white,
    textOnSecondary: Colors.white,
    surface: Colors.white,
    error: const Color.fromARGB(255, 128, 12, 4),
    textOnError: Colors.white,
    textOnSurface: Colors.black,
  );
}

ThemeData generateTheme({
  required Color primary,
  required Color secondary,
  required Color tertiary,
  required Color primaryAccent,
  required Color secondaryAccent,
  required Color tertiaryAccent,
  required Color textOnPrimary,
  required Color textOnSecondary,
  required Color surface,
  required Color error,
  required Color textOnError,
  required Color textOnSurface,
}) {
  return ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: textOnPrimary,
      secondary: secondary,
      onSecondary: textOnSecondary,
      error: error,
      onError: textOnError,
      surface: surface,
      onSurface: textOnSurface,
      tertiary: tertiary,
      onTertiary: tertiaryAccent,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
