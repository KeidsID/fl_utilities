// coverage:ignore-file

import 'package:flutter/material.dart';

/// {@template fl_utils.src.others.DialogPage}
/// [Page] that suitable for [Dialog]. This is the same as calling
/// the [showDialog] method, but this [Page] can work with `go_router`.
/// {@endtemplate}
class DialogPage<T> extends Page<T> {
  /// {@macro fl_utils.src.others.DialogPage}
  const DialogPage({
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
    required this.builder,
    this.themes,
    this.barrierColor = Colors.black54,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.anchorPoint,
    this.useSafeArea = true,
    this.traversalEdgeBehavior,
  });

  final WidgetBuilder builder;
  final CapturedThemes? themes;

  /// {@macro flutter.widgets.ModalRoute.barrierColor}
  final Color? barrierColor;

  /// {@macro flutter.widgets.ModalRoute.barrierDismissible}
  final bool barrierDismissible;

  /// {@macro flutter.widgets.ModalRoute.barrierLabel}
  final String? barrierLabel;

  /// Whether to wrap the dialog in a [SafeArea].
  final bool useSafeArea;

  /// {@macro flutter.widgets.DisplayFeatureSubScreen.anchorPoint}
  final Offset? anchorPoint;

  /// Controls the transfer of focus beyond the first and the last items of a
  /// [FocusScopeNode].
  ///
  /// If set to null, [Navigator.routeTraversalEdgeBehavior] is used.
  final TraversalEdgeBehavior? traversalEdgeBehavior;

  @override
  Route<T> createRoute(BuildContext context) {
    return DialogRoute<T>(
      context: context,
      builder: builder,
      themes: themes,
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      settings: this,
      anchorPoint: anchorPoint,
      traversalEdgeBehavior: traversalEdgeBehavior,
    );
  }
}
