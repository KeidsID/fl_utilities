import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:fl_utilities/fl_utilities.dart';

void main() {
  group('TextX', () {
    group('.applyOpacity -', () {
      const appliedOpacity = 0.5;

      const defaultTextStyleKey = ValueKey('default-text-style');
      const directStyle = TextStyle(color: Colors.amber);

      const textKey = ValueKey('text');
      const richTextKey = ValueKey('rich-text');
      const textWithStyleKey = ValueKey('text-with-style');

      Widget testSubject() {
        return MaterialApp(
          home: Scaffold(
            body: DefaultTextStyle(
              key: defaultTextStyleKey,
              style: const TextStyle(color: Colors.white),
              child: Column(
                children: [
                  const Text('data').applyOpacity(
                    key: textKey,
                    opacity: appliedOpacity,
                  ),
                  const Text.rich(TextSpan(text: 'data')).applyOpacity(
                    key: richTextKey,
                    opacity: appliedOpacity,
                  ),
                  const Text('data', style: directStyle).applyOpacity(
                    key: textWithStyleKey,
                    opacity: appliedOpacity,
                  ),
                ],
              ),
            ),
          ),
        );
      }

      const testDesc =
          'should return a new [Text] with modified style color opacity';
      testWidgets('$testDesc ([DefaultTextStyle] reference)', (tester) async {
        await tester.pumpWidget(testSubject());

        final defaultStyle = tester
            .widget<DefaultTextStyle>(find.byKey(defaultTextStyleKey))
            .style;
        final actualText = tester.widget<Text>(find.byKey(textKey));
        final actualRichText = tester.widget<Text>(find.byKey(richTextKey));

        // expect modified [DefaultTextStyle] opcaity.

        final expectedStyle = defaultStyle.apply(
          color: defaultStyle.color?.withOpacity(appliedOpacity),
        );

        expect(actualText.style, expectedStyle);
        expect(actualRichText.style, expectedStyle);
      });
      testWidgets('$testDesc (direct [TextStyle] reference)', (tester) async {
        await tester.pumpWidget(testSubject());

        final actualText = tester.widget<Text>(find.byKey(textWithStyleKey));

        // expect modified [directStyle] opcaity.
        expect(
          actualText.style,
          directStyle.apply(
            color: directStyle.color?.withOpacity(appliedOpacity),
          ),
        );
      });
    });
  });

  group('TextStyleX.applyOpacity -', () {
    test('should return a new [TextStyle] with modified opacity', () {
      const appliedOpacity = 0.5;
      const style = TextStyle(color: Colors.amber);

      final actual = style.applyOpacity(appliedOpacity);

      expect(actual.color, style.color?.withOpacity(appliedOpacity));
    });
  });
}
