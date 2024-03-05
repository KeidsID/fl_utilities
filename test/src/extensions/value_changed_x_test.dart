import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fl_utils/src/extensions/value_changed_x.dart';

void main() {
  group('ValueChangedX.debounce', () {
    const msDelay = 500;
    test('should call only once after delay without further events', () async {
      final callbackState = ValueChangedState<String>();
      final debouncedCallback = callbackState.callback.debounce(
        delay: const Duration(milliseconds: msDelay),
      );

      // Call with debounce
      debouncedCallback('first');
      expect(callbackState.isCalled, false);

      // wait 250ms delay (half before [ValueChanged] called).
      await Future.delayed(const Duration(milliseconds: (msDelay ~/ 2)));

      // Verify no call yet
      await expectLater(callbackState.isCalled, false);

      // wait until callback called.
      await Future.delayed(const Duration(milliseconds: (msDelay ~/ 2)));

      // Verify only one call with the first value
      await expectLater(callbackState.isCalled, true);
      await expectLater(callbackState.lastValue, 'first');
    });

    test(
      'should cancel previous timer and call with the latest value',
      () async {
        final callbackState = ValueChangedState<String>();
        final debouncedCallback = callbackState.callback.debounce(
          delay: const Duration(milliseconds: msDelay),
        );

        // Send initial event
        debouncedCallback('first');
        expect(callbackState.isCalled, false);

        // Send another event before delay
        debouncedCallback('second');
        expect(callbackState.isCalled, false);

        // Wait for delay
        await Future.delayed(const Duration(milliseconds: msDelay));

        // Verify only one call with the latest value
        await expectLater(callbackState.isCalled, true);
        await expectLater(callbackState.lastValue, 'second');
      },
    );
  });
}

/// Helper class for testing.
class ValueChangedState<T> {
  ValueChangedState();

  /// [callback] called once.
  bool isCalled = false;

  /// Last value called from [callback].
  T? lastValue;

  ValueChanged<T> get callback {
    return (T value) {
      isCalled = true;
      lastValue = value;
    };
  }
}
