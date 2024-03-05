import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  /// [Theme.of] shorthand.
  ThemeData get theme => Theme.of(this);

  /// `Theme.of(context).colorScheme` shorthand.
  ColorScheme get colorScheme => theme.colorScheme;

  /// `Theme.of(context).textTheme` shorthand.
  TextTheme get textTheme => theme.textTheme;

  /// [MediaQuery.maybeOf] shorthand.
  MediaQueryData? get mediaQuery => MediaQuery.maybeOf(this);

  /// [Scaffold.maybeOf] shorthand.
  ScaffoldState? get scaffold => Scaffold.maybeOf(this);

  /// [ScaffoldMessenger.maybeOf] shorthand. Commonly used to show [SnackBar].
  ScaffoldMessengerState? get scaffoldMessenger =>
      ScaffoldMessenger.maybeOf(this);
}
