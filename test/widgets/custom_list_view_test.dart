import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fl_utilities/fl_utilities.dart';

Future<void> pumpTest(
  WidgetTester tester, {
  List<CustomListViewItemDelegate> children = const [],
}) async {
  await tester.pumpWidget(MaterialApp(
    home: CustomListView.builder(
      itemCount: children.length,
      itemBuilder: (_, index) => children[index],
    ),
  ));
}

void main() {}
