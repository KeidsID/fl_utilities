import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fl_utilities/fl_utilities.dart';

Future<void> pumpTest(
  WidgetTester tester, {
  TextDirection textDirection = TextDirection.ltr,
  Axis scrollDirection = Axis.vertical,
  bool reverse = false,
  double? itemExtent,
  Widget? prototypeItem,
  CustomListViewDelegate? viewDelegate,
  List<CustomListViewItemDelegate> children = const [],
}) async {
  await tester.pumpWidget(MaterialApp(
    home: Directionality(
      textDirection: textDirection,
      child: CustomListView(
        scrollDirection: scrollDirection,
        reverse: reverse,
        itemExtent: itemExtent,
        prototypeItem: prototypeItem,
        viewDelegate: viewDelegate,
        children: children,
      ),
    ),
  ));

  await tester.pump(const Duration(seconds: 5));
}

CustomListViewItem getItem(WidgetTester tester, {bool last = false}) {
  final finder = find.byType(CustomListViewItem);

  return tester.widget<CustomListViewItem>(last ? finder.last : finder.first);
}

Container getContainer(WidgetTester tester, {bool last = false}) {
  final finder = find.byType(Container);

  return tester.widget<Container>(last ? finder.last : finder.first);
}

SizedBox getSizedBox(WidgetTester tester, {bool last = false}) {
  final finder = find.byType(SizedBox);

  return tester.widget<SizedBox>(last ? finder.last : finder.first);
}

void main() {
  group('CustomListView', () {
    testWidgets('.builder - supports null items', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: CustomListView.builder(
          itemCount: 42,
          itemBuilder: (BuildContext context, int index) {
            if (index == 5) {
              return null;
            }

            return const CustomListViewItemDelegate(child: Text('item'));
          },
        ),
      ));

      expect(find.text('item'), findsNWidgets(5));
    });

    testWidgets('.separated - supports null items in itemBuilder',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: CustomListView.separated(
          itemCount: 42,
          separatorBuilder: (BuildContext context, int index) {
            return const CustomListViewItemDelegate(child: Text('separator'));
          },
          itemBuilder: (BuildContext context, int index) {
            if (index == 5) {
              return null;
            }

            return const CustomListViewItemDelegate(child: Text('item'));
          },
        ),
      ));

      expect(find.text('item'), findsNWidgets(5));
      expect(find.text('separator'), findsNWidgets(5));
    });
  });

  group('CustomListViewItem', () {
    testWidgets('- should sized correctly', (tester) async {
      const List<CustomListViewItemDelegate> children = [
        CustomListViewItemDelegate(
          mainAxisLength: 160.0,
          crossAxisLength: 320.0,
        ),
        CustomListViewItemDelegate(mainAxisLength: 160.0),
      ];

      await pumpTest(tester, children: children);

      expect(getItem(tester).width, 320.0);
      expect(getItem(tester).height, 160.0);
      expect(getSizedBox(tester).width, 320.0);
      expect(getContainer(tester).constraints?.maxHeight, 160.0);

      // stretch
      expect(getItem(tester, last: true).width, double.infinity);
      expect(getItem(tester, last: true).height, 160.0);
      expect(getContainer(tester, last: true).constraints?.maxWidth,
          double.infinity);
      expect(getContainer(tester, last: true).constraints?.maxHeight, 160.0);

      await pumpTest(
        tester,
        scrollDirection: Axis.horizontal,
        children: children,
      );

      expect(getItem(tester).width, 160.0);
      expect(getItem(tester).height, 320.0);
      expect(getContainer(tester).constraints?.maxWidth, 160.0);
      expect(getSizedBox(tester).height, 320.0);

      // stretch
      expect(getItem(tester, last: true).width, 160.0);
      expect(getItem(tester, last: true).height, double.infinity);
      expect(getContainer(tester, last: true).constraints?.maxWidth, 160.0);
      expect(getContainer(tester, last: true).constraints?.maxHeight,
          double.infinity);
    });

    testWidgets('- should aligned correctly', (tester) async {
      await pumpTest(tester, children: const [
        CustomListViewItemDelegate.square(dimension: 160.0),
      ]);

      expect(getContainer(tester).alignment, Alignment.center);

      const List<CustomListViewItemDelegate> children = [
        CustomListViewItemDelegate.square(
          dimension: 160.0,
          crossAxisAlignment: CustomListViewItemAlignment.start,
        ),
        CustomListViewItemDelegate.square(
          dimension: 160.0,
          crossAxisAlignment: CustomListViewItemAlignment.end,
        ),
      ];

      await pumpTest(tester, children: children);

      expect(getContainer(tester).alignment, Alignment.centerLeft);
      expect(getContainer(tester, last: true).alignment, Alignment.centerRight);

      await pumpTest(
        tester,
        scrollDirection: Axis.horizontal,
        children: children,
      );

      expect(getContainer(tester).alignment, Alignment.topCenter);
      expect(
        getContainer(tester, last: true).alignment,
        Alignment.bottomCenter,
      );

      await pumpTest(
        tester,
        reverse: true,
        children: children,
      );

      expect(getContainer(tester).alignment, Alignment.centerRight);
      expect(getContainer(tester, last: true).alignment, Alignment.centerLeft);

      await pumpTest(
        tester,
        textDirection: TextDirection.rtl,
        children: children,
      );

      expect(getContainer(tester).alignment, Alignment.centerRight);
      expect(getContainer(tester, last: true).alignment, Alignment.centerLeft);

      await pumpTest(
        tester,
        textDirection: TextDirection.rtl,
        reverse: true,
        children: children,
      );

      expect(getContainer(tester).alignment, Alignment.centerLeft);
      expect(getContainer(tester, last: true).alignment, Alignment.centerRight);
    });

    group('.isStretch -', () {
      testWidgets(
        'should return true if delegate "crossAxisLength" is null or "crossAxisAlignment" is stretch',
        (tester) async {
          await pumpTest(tester, itemExtent: 160.0, children: const [
            CustomListViewItemDelegate(crossAxisLength: null),
          ]);

          expect(getItem(tester).isStretch, true);

          await pumpTest(tester, itemExtent: 160.0, children: const [
            CustomListViewItemDelegate(
              crossAxisAlignment: CustomListViewItemAlignment.stretch,
            ),
          ]);

          expect(getItem(tester).isStretch, true);

          await pumpTest(tester, children: const [
            CustomListViewItemDelegate.square(dimension: 160.0),
          ]);

          expect(getItem(tester).isStretch, false);
        },
      );

      testWidgets(
        'should cause [CustomListViewItem] to build [SizedBox] if false',
        (tester) async {
          await pumpTest(tester, itemExtent: 160.0, children: const [
            CustomListViewItemDelegate(crossAxisLength: null),
          ]);

          expect(find.byType(SizedBox), findsNothing);

          await pumpTest(tester, children: const [
            CustomListViewItemDelegate.square(dimension: 160.0),
          ]);

          expect(find.byType(SizedBox), findsOneWidget);
        },
      );
    });

    testWidgets(
      'isExtended - should return true if [CustomListView.itemExtent] or [CustomListView.prototypeItem] is not null',
      (tester) async {
        const children = [CustomListViewItemDelegate.square(dimension: 160.0)];

        await pumpTest(tester, itemExtent: 160.0, children: children);

        expect(getItem(tester).isExtended, true);

        await pumpTest(
          tester,
          prototypeItem: const SizedBox.square(dimension: 80.0),
          children: children,
        );

        expect(getItem(tester).isExtended, true);

        await pumpTest(tester, children: children);

        expect(getItem(tester).isExtended, false);
      },
    );
  });

  test(
    'CustomListViewItemDelegate - asserts on infinity "mainAxisLength"',
    () {
      expect(
        () => CustomListViewItemDelegate(mainAxisLength: double.infinity),
        throwsAssertionError,
      );

      expect(
        () => CustomListViewItemDelegate.square(dimension: double.infinity),
        throwsAssertionError,
      );
    },
  );

  group('CustomListViewDelegate -', () {
    test(
      'asserts on infinity "mainAxisLength"',
      () {
        expect(
          () => CustomListViewDelegate(mainAxisLength: double.infinity),
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      '- should be used as default item delegate on [CustomListViewItem] widget',
      (tester) async {
        const expectedWidth = 200.0;
        const expectedHeight = 100.0;
        const expectedCrossAxisAlignment = CustomListViewItemAlignment.start;

        await pumpTest(
          tester,
          viewDelegate: const CustomListViewDelegate(
            mainAxisLength: expectedHeight,
            crossAxisLength: expectedWidth,
            crossAxisAlignment: expectedCrossAxisAlignment,
          ),
          children: [
            const CustomListViewItemDelegate(child: Card()),
            const CustomListViewItemDelegate(child: Card()),
          ],
        );

        final firstItem = getItem(tester);
        final lastItem = getItem(tester, last: true);

        expect(firstItem.width, expectedWidth);
        expect(firstItem.height, expectedHeight);
        expect(firstItem.crossAxisAlignment, expectedCrossAxisAlignment);
        expect(lastItem.width, expectedWidth);
        expect(lastItem.height, expectedHeight);
        expect(lastItem.crossAxisAlignment, expectedCrossAxisAlignment);
      },
    );
  });
}
