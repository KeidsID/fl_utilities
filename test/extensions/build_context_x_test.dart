import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fl_utilities/fl_utilities.dart';

/// Can't compare [ThemeData] instances directly.
///
/// Try comparing the properties.
final expectedThm = ThemeData.from(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  useMaterial3: true,
);

ColorScheme get expectedColorScheme => expectedThm.colorScheme;
TextTheme get expectedTextTheme => expectedThm.textTheme;

const expectedScrollBehavior = ScrollBehavior();

Widget get testSubject {
  return MaterialApp(
    theme: expectedThm,
    scrollBehavior: expectedScrollBehavior,
    home: const Scaffold(body: Text('Hello')),
  );
}

/// Get the latest [BuildContext] from [testSubject].
BuildContext getContext(WidgetTester tester) =>
    tester.element(find.byType(Text));

void main() {
  group('BuildContextX', () {
    testWidgets('theme - should return [ThemeData] from [Theme.of]',
        (tester) async {
      await tester.pumpWidget(testSubject);

      final thm = getContext(tester).theme;

      // GENERAL CONFIGURATION
      expect(thm.applyElevationOverlayColor,
          expectedThm.applyElevationOverlayColor);
      expect(thm.cupertinoOverrideTheme, expectedThm.cupertinoOverrideTheme);
      expect(mapEquals(thm.extensions, expectedThm.extensions), true);
      expect(thm.inputDecorationTheme, expectedThm.inputDecorationTheme);
      expect(thm.materialTapTargetSize, expectedThm.materialTapTargetSize);
      expect(thm.pageTransitionsTheme, expectedThm.pageTransitionsTheme);
      expect(thm.platform, expectedThm.platform);
      expect(thm.scrollbarTheme, expectedThm.scrollbarTheme);
      expect(thm.splashFactory, expectedThm.splashFactory);
      expect(thm.useMaterial3, expectedThm.useMaterial3);
      expect(thm.visualDensity, expectedThm.visualDensity);

      // COLOR
      expect(thm.canvasColor, expectedThm.canvasColor);
      expect(thm.cardColor, expectedThm.cardColor);
      expect(thm.colorScheme, expectedThm.colorScheme);
      expect(thm.dialogBackgroundColor, expectedThm.dialogBackgroundColor);
      expect(thm.disabledColor, expectedThm.disabledColor);
      expect(thm.dividerColor, expectedThm.dividerColor);
      expect(thm.focusColor, expectedThm.focusColor);
      expect(thm.highlightColor, expectedThm.highlightColor);
      expect(thm.hintColor, expectedThm.hintColor);
      expect(thm.hoverColor, expectedThm.hoverColor);
      expect(thm.indicatorColor, expectedThm.indicatorColor);
      expect(thm.primaryColor, expectedThm.primaryColor);
      expect(thm.primaryColorDark, expectedThm.primaryColorDark);
      expect(thm.primaryColorLight, expectedThm.primaryColorLight);
      expect(thm.scaffoldBackgroundColor, expectedThm.scaffoldBackgroundColor);
      expect(thm.secondaryHeaderColor, expectedThm.secondaryHeaderColor);
      expect(thm.shadowColor, expectedThm.shadowColor);
      expect(thm.splashColor, expectedThm.splashColor);
      expect(thm.unselectedWidgetColor, expectedThm.unselectedWidgetColor);

      // TYPOGRAPHY & ICONOGRAPHY
      expect(thm.iconTheme, expectedThm.iconTheme);
      expect(thm.primaryIconTheme, expectedThm.primaryIconTheme);
      expect(
        thm.primaryTextTheme,
        Theme.of(getContext(tester)).primaryTextTheme,
      );
      expect(thm.textTheme, Theme.of(getContext(tester)).textTheme);
      expect(thm.typography, expectedThm.typography);

      // COMPONENT THEMES
      expect(thm.actionIconTheme, expectedThm.actionIconTheme);
      expect(thm.appBarTheme, expectedThm.appBarTheme);
      expect(thm.badgeTheme, expectedThm.badgeTheme);
      expect(thm.bannerTheme, expectedThm.bannerTheme);
      expect(thm.bottomAppBarTheme, expectedThm.bottomAppBarTheme);
      expect(
          thm.bottomNavigationBarTheme, expectedThm.bottomNavigationBarTheme);
      expect(thm.bottomSheetTheme, expectedThm.bottomSheetTheme);
      expect(thm.buttonBarTheme, expectedThm.buttonBarTheme);
      expect(thm.buttonTheme, expectedThm.buttonTheme);
      expect(thm.cardTheme, expectedThm.cardTheme);
      expect(thm.checkboxTheme, expectedThm.checkboxTheme);
      expect(thm.chipTheme, expectedThm.chipTheme);
      expect(thm.dataTableTheme, expectedThm.dataTableTheme);
      expect(thm.datePickerTheme, expectedThm.datePickerTheme);
      expect(thm.dialogTheme, expectedThm.dialogTheme);
      expect(thm.dividerTheme, expectedThm.dividerTheme);
      expect(thm.drawerTheme, expectedThm.drawerTheme);
      expect(thm.dropdownMenuTheme, expectedThm.dropdownMenuTheme);
      expect(thm.elevatedButtonTheme, expectedThm.elevatedButtonTheme);
      expect(thm.expansionTileTheme, expectedThm.expansionTileTheme);
      expect(thm.filledButtonTheme, expectedThm.filledButtonTheme);
      expect(
          thm.floatingActionButtonTheme, expectedThm.floatingActionButtonTheme);
      expect(thm.iconButtonTheme, expectedThm.iconButtonTheme);
      expect(thm.listTileTheme, expectedThm.listTileTheme);
      expect(thm.menuBarTheme, expectedThm.menuBarTheme);
      expect(thm.menuButtonTheme, expectedThm.menuButtonTheme);
      expect(thm.menuTheme, expectedThm.menuTheme);
      expect(thm.navigationBarTheme, expectedThm.navigationBarTheme);
      expect(thm.navigationDrawerTheme, expectedThm.navigationDrawerTheme);
      expect(thm.navigationRailTheme, expectedThm.navigationRailTheme);
      expect(thm.outlinedButtonTheme, expectedThm.outlinedButtonTheme);
      expect(thm.popupMenuTheme, expectedThm.popupMenuTheme);
      expect(thm.progressIndicatorTheme, expectedThm.progressIndicatorTheme);
      expect(thm.radioTheme, expectedThm.radioTheme);
      expect(thm.searchBarTheme, expectedThm.searchBarTheme);
      expect(thm.searchViewTheme, expectedThm.searchViewTheme);
      expect(thm.segmentedButtonTheme, expectedThm.segmentedButtonTheme);
      expect(thm.sliderTheme, expectedThm.sliderTheme);
      expect(thm.snackBarTheme, expectedThm.snackBarTheme);
      expect(thm.switchTheme, expectedThm.switchTheme);
      expect(thm.tabBarTheme, expectedThm.tabBarTheme);
      expect(thm.textButtonTheme, expectedThm.textButtonTheme);
      expect(thm.textSelectionTheme, expectedThm.textSelectionTheme);
      expect(thm.timePickerTheme, expectedThm.timePickerTheme);
      expect(thm.toggleButtonsTheme, expectedThm.toggleButtonsTheme);
      expect(thm.tooltipTheme, expectedThm.tooltipTheme);
    });

    testWidgets(
      'colorScheme - should return [ColorScheme] from [Theme.of]',
      (tester) async {
        await tester.pumpWidget(testSubject);

        final context = getContext(tester);
        final expected = Theme.of(context).colorScheme;
        final actual = context.colorScheme;

        expect(actual, expected);
      },
    );

    testWidgets(
      'textTheme - should return [TextTheme] from [Theme.of]',
      (tester) async {
        await tester.pumpWidget(testSubject);

        final context = getContext(tester);
        final expected = Theme.of(context).textTheme;
        final actual = context.textTheme;

        expect(actual, expected);
      },
    );

    testWidgets(
      'mediaQuery - should return [MediaQueryData] from [MediaQuery.of]',
      (tester) async {
        const expectedSize = Size(400.0, 900.0);

        final dpi = tester.view.devicePixelRatio;

        // stub tester screen size.
        tester.view.physicalSize = Size(
          expectedSize.width * dpi,
          expectedSize.height * dpi,
        );

        await tester.pumpWidget(testSubject);

        final BuildContext context = getContext(tester);

        final expectedMediaQuery = MediaQuery.of(context);
        final actualMediaQuery = context.mediaQuery;

        expect(actualMediaQuery, expectedMediaQuery);
        expect(actualMediaQuery.size, expectedSize);
      },
    );

    group('scaffold -', () {
      testWidgets(
        'should return [ScaffoldState] from [Scaffold.of]',
        (tester) async {
          await tester.pumpWidget(testSubject);

          final BuildContext context = getContext(tester);

          final expected = Scaffold.of(context);
          final actual = context.scaffold;

          expect(actual, expected);
        },
      );
      testWidgets(
        'should return null if no [ScaffoldState] is found in scope',
        (tester) async {
          await tester.pumpWidget(const MaterialApp(home: Placeholder()));

          final BuildContext context = tester.element(find.byType(Placeholder));

          final expected = Scaffold.maybeOf(context);
          final actual = context.scaffold;

          expect(actual, expected);
        },
      );
    });

    group('scaffoldMessenger -', () {
      testWidgets(
        'should return [ScaffoldMessengerState] from [ScaffoldMessenger.of]',
        (tester) async {
          await tester.pumpWidget(testSubject);

          final BuildContext context = getContext(tester);

          final expected = ScaffoldMessenger.of(context);
          final actual = context.scaffoldMessenger;

          expect(actual, expected);
        },
      );
      testWidgets(
        'should return null if no [ScaffoldMessengerState] is found in scope',
        (tester) async {
          await tester.pumpWidget(const MaterialApp(home: Placeholder()));

          final BuildContext context = tester.element(find.byType(Placeholder));

          final expected = ScaffoldMessenger.maybeOf(context);
          final actual = context.scaffoldMessenger;

          expect(actual, expected);
        },
      );
    });

    testWidgets(
      'scrollBehavior - should return [ScrollBehavior] from [ScrollConfiguration.of]',
      (tester) async {
        await tester.pumpWidget(testSubject);

        final actual = getContext(tester).scrollBehavior;

        expect(actual, expectedScrollBehavior);
      },
    );
  });
}
