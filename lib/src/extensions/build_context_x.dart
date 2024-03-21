import 'package:flutter/material.dart';

/// Extension on [BuildContext].
///
/// Mostly contains shorthands for commonly used flutter utilities like
/// [Theme.of], [MediaQuery.of], etc.
///
/// {@tool snippet}
/// ```dart
/// Builder(builder: (context) {
///   context.theme; // instead of `Theme.of(context)`
///   context.textTheme; // instead of `Theme.of(context).textTheme`
///   context.mediaQuery; // instead of `MediaQuery.of(context)`
///
///   return const Placeholder();
/// });
/// ```
/// {@end-tool}
extension BuildContextX on BuildContext {
  /// Get the closest [ThemeData] instance.
  ///
  /// [Theme.of] shorthand.
  ThemeData get theme => Theme.of(this);

  /// Get the closest [ColorScheme] instance.
  ///
  /// `Theme.of(context).colorScheme` shorthand.
  ColorScheme get colorScheme => theme.colorScheme;

  /// Get the closest [TextTheme] instance.
  ///
  /// `Theme.of(context).textTheme` shorthand.
  TextTheme get textTheme => theme.textTheme;

  /// Get the closest [MediaQueryData] instance. May return null.
  ///
  /// [MediaQuery.maybeOf] shorthand.
  MediaQueryData? get mediaQuery => MediaQuery.maybeOf(this);

  /// Get the closest [ScaffoldState] instance. May return null.
  ///
  /// Commonly used to show [BottomSheet] ([ScaffoldState.showBottomSheet]).
  ///
  /// [Scaffold.maybeOf] shorthand.
  ScaffoldState? get scaffold => Scaffold.maybeOf(this);

  /// Get the closest [ScaffoldMessengerState] instance. May return null.
  ///
  /// Commonly used to show [SnackBar] ([ScaffoldMessengerState.showSnackBar]).
  ///
  /// [ScaffoldMessenger.maybeOf] shorthand.
  ScaffoldMessengerState? get scaffoldMessenger =>
      ScaffoldMessenger.maybeOf(this);

  /// Get the closest [ScrollBehavior] instance from [ScrollConfiguration].
  ///
  /// If no [ScrollConfiguration] widget is in scope of the given context, a
  /// default [ScrollBehavior] instance is returned.
  ///
  /// [ScrollConfiguration.of] shorthand.
  ScrollBehavior get scrollBehavior => ScrollConfiguration.of(this);
}
