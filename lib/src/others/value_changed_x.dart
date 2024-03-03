import 'dart:async';

import 'package:flutter/material.dart';

extension ValueChangedX<T> on ValueChanged<T> {
  /// Prevent callback from being called too often.
  ///
  /// Example:
  /// ```dart
  /// TextField(
  ///   onChanged: (text) {
  ///     debugPrint('Called after half a second of not typing');
  ///   }.debounce(),
  /// );
  /// ```
  ValueChanged<T> debounce({
    Duration delay = const Duration(milliseconds: 500),
  }) {
    Timer? timer;

    return (T value) {
      if (timer != null) timer!.cancel();

      timer = Timer(delay, () => this(value));
    };
  }
}
