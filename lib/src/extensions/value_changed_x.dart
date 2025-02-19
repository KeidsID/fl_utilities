import 'dart:async';

import 'package:flutter/material.dart';

/// Extension on [ValueChanged].
extension ValueChangedX<T> on ValueChanged<T> {
  /// Prevent callback from being called too often.
  ///
  /// ```dart
  /// import "package:flutter/material.dart";
  /// import "package:fl_utilities/fl_utilities.dart";
  ///
  /// final myWidget = TextField(
  ///   onChanged: (text) {
  ///     debugPrint('Called after half a second of not typing');
  ///   }.debounce(),
  /// );
  /// ```
  ValueChanged<T> debounce([
    Duration duration = const Duration(milliseconds: 500),
  ]) {
    Timer? timer;

    return (T value) {
      if (timer != null) timer!.cancel();

      timer = Timer(duration, () => this(value));
    };
  }
}
