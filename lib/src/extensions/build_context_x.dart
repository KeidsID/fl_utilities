import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Extension on [BuildContext].
///
/// Contains shorthands for flutter utilities like
/// [Theme.of], [MediaQuery.of], etc.
///
/// ```dart
/// Builder(builder: (context) {
///   context.theme; // instead of `Theme.of(context)`
///   context.textTheme; // instead of `Theme.of(context).textTheme`
///   context.mediaSize; // instead of `MediaQuery.sizeOf(context)`
///
///   return const Placeholder();
/// });
/// ```
extension BuildContextX on BuildContext {
  /// [Theme.of] shorthand.
  ThemeData get theme => Theme.of(this);

  /// `Theme.of(context).colorScheme` shorthand.
  ColorScheme get colorScheme => theme.colorScheme;

  /// `Theme.of(context).textTheme` shorthand.
  TextTheme get textTheme => theme.textTheme;

  /// [Scaffold.of] shorthand.
  ScaffoldState get scaffold => Scaffold.of(this);

  /// [ScaffoldMessenger.of] shorthand.
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  /// [ScrollConfiguration.of] shorthand.
  ScrollBehavior get scrollBehavior => ScrollConfiguration.of(this);

  /// [MediaQuery.of] shorthand.
  ///
  /// Feels heavy? try `context.media{Property}` syntax to get only the
  /// properties you need, e.g [mediaSize] which is [MediaQuery.sizeOf]
  /// shorthand.
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// [MediaQuery.sizeOf] shorthand.
  Size get mediaSize => MediaQuery.sizeOf(this);

  /// [MediaQuery.devicePixelRatioOf] shorthand.
  double get mediaDevicePixelRatio => MediaQuery.devicePixelRatioOf(this);

  /// Deprecated. Will be removed in a future version of Flutter.
  /// Use [mediaTextScaler] instead.
  ///
  /// [MediaQuery.textScaleFactorOf] shorthand.
  @Deprecated(
    'Use mediaTextScaler instead. '
    'Use of textScaleFactor was deprecated in preparation for the upcoming nonlinear text scaling support. '
    'This feature was deprecated after SDK v3.12.0-2.0.pre.',
  )
  double get mediaTextScaleFactor => MediaQuery.textScaleFactorOf(this);

  /// [MediaQuery.textScalerOf] shorthand.
  TextScaler get mediaTextScaler => MediaQuery.textScalerOf(this);

  /// [MediaQuery.platformBrightnessOf] shorthand.
  Brightness get mediaPlatformBrightness =>
      MediaQuery.platformBrightnessOf(this);

  /// [MediaQuery.viewInsetsOf] shorthand.
  EdgeInsets get mediaViewInsets => MediaQuery.viewInsetsOf(this);

  /// [MediaQuery.paddingOf] shorthand.
  EdgeInsets get mediaPadding => MediaQuery.paddingOf(this);

  /// [MediaQuery.viewPaddingOf] shorthand.
  EdgeInsets get mediaViewPadding => MediaQuery.viewPaddingOf(this);

  /// [MediaQuery.systemGestureInsetsOf] shorthand.
  EdgeInsets get mediaSystemGestureInsets =>
      MediaQuery.systemGestureInsetsOf(this);

  /// [MediaQuery.alwaysUse24HourFormatOf] shorthand.
  bool get mediaAlwaysUse24HourFormat =>
      MediaQuery.alwaysUse24HourFormatOf(this);

  /// [MediaQuery.accessibleNavigationOf] shorthand.
  bool get mediaAccessibleNavigation => MediaQuery.accessibleNavigationOf(this);

  /// [MediaQuery.invertColorsOf] shorthand.
  bool get mediaInvertColors => MediaQuery.invertColorsOf(this);

  /// [MediaQuery.highContrastOf] shorthand.
  bool get mediaHighContrast => MediaQuery.highContrastOf(this);

  /// [MediaQuery.disableAnimationsOf] shorthand.
  bool get mediaDisableAnimations => MediaQuery.disableAnimationsOf(this);

  /// [MediaQuery.boldTextOf] shorthand.
  bool get mediaBoldText => MediaQuery.boldTextOf(this);

  /// [MediaQuery.navigationModeOf] shorthand.
  NavigationMode get mediaNavigationMode => MediaQuery.navigationModeOf(this);

  /// [MediaQuery.gestureSettingsOf] shorthand.
  DeviceGestureSettings get mediaGestureSettings =>
      MediaQuery.gestureSettingsOf(this);

  /// [MediaQuery.displayFeaturesOf] shorthand.
  List<ui.DisplayFeature> get mediaDisplayFeatures =>
      MediaQuery.displayFeaturesOf(this);

  /// [MediaQuery.orientationOf] shorthand.
  Orientation get mediaOrientation => MediaQuery.orientationOf(this);
}
