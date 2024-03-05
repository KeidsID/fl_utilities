import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:fl_utils/src/extensions/text_x.dart';

void main() {
  group('TextX', () {
    const subject = Text(
      'test subject',
      style: TextStyle(color: Colors.white),
    );
    final color = subject.style?.color;

    test('.applyOpacity should return a new Text with specified opacity', () {
      const opactiy = 0.5;
      final actual = subject.applyOpacity(opactiy);

      expect(actual.data, subject.data);
      expect(
        actual.style,
        subject.style?.apply(color: color?.withOpacity(opactiy)),
      );
    });
  });
}
