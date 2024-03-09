import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fl_utilities/fl_utilities.dart';

/// {@template fl_utils.src.widgets.SizedScrollableArea}
/// A scrollable area that can be sized.
///
/// This widget act like any [Scrollable] widget which can detect mouse/mobile
/// drag and mouse wheel scroll.
///
/// Its usefull when you need extra scrollable area if your [Scrollable] widget
/// must have fixed size.
///
/// {@tool dartpad}
/// ** See code in example/lib/src/widgets/sized_scrollable_area.dart **
/// {@end-tool}
/// {@endtemplate}
class SizedScrollableArea extends StatefulWidget {
  /// {@macro fl_utils.src.widgets.SizedScrollableArea}
  const SizedScrollableArea({
    super.key,
    this.controller,
    this.primary,
    this.physics,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.width,
    this.height,
    this.child,
  });

  /// {@macro fl_utils.src.widgets.SizedScrollableArea}
  const SizedScrollableArea.expand({
    super.key,
    this.controller,
    this.primary,
    this.physics,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.child,
  })  : width = double.infinity,
        height = double.infinity;

  /// {@macro fl_utils.src.widgets.SizedScrollableArea}
  const SizedScrollableArea.shrink({
    super.key,
    this.controller,
    this.primary,
    this.physics,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.child,
  })  : width = 0.0,
        height = 0.0;

  /// {@macro fl_utils.src.widgets.SizedScrollableArea}
  SizedScrollableArea.fromSize({
    super.key,
    this.controller,
    this.primary,
    this.physics,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    Size? size,
    this.child,
  })  : width = size?.width,
        height = size?.height;

  /// {@macro flutter.widgets.scroll_view.controller}
  const SizedScrollableArea.square({
    super.key,
    this.controller,
    this.primary,
    this.physics,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    double? dimension,
    this.child,
  })  : width = dimension,
        height = dimension;

  /// {@macro flutter.widgets.scroll_view.controller}
  final ScrollController? controller;

  /// {@macro flutter.widgets.scroll_view.primary}
  final bool? primary;

  /// {@macro flutter.widgets.scroll_view.physics}
  final ScrollPhysics? physics;

  /// {@macro flutter.widgets.scroll_view.scrollDirection}
  final Axis scrollDirection;

  /// {@macro flutter.widgets.scroll_view.reverse}
  final bool reverse;

  /// If non-null, requires the child to have exactly this width.
  final double? width;

  /// If non-null, requires the child to have exactly this height.
  final double? height;

  /// In case you need to add decoration widget such as [Container].
  final Widget? child;

  @override
  State<SizedScrollableArea> createState() => SizedScrollableAreaState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    final DiagnosticLevel sizeLevel =
        ((width == double.infinity && height == double.infinity) ||
                (width == 0.0 && height == 0.0))
            ? DiagnosticLevel.hidden
            : DiagnosticLevel.info;

    properties
      ..add(
        DoubleProperty('width', width, defaultValue: null, level: sizeLevel),
      )
      ..add(
        DoubleProperty('height', height, defaultValue: null, level: sizeLevel),
      )

      //
      ..add(EnumProperty<Axis>('scrollDirection', scrollDirection))
      ..add(DiagnosticsProperty<ScrollPhysics>(
        'physics',
        physics,
        showName: false,
        defaultValue: null,
      ))
      ..add(FlagProperty(
        'reverse',
        value: reverse,
        ifTrue: 'reversed',
        showName: true,
      ))
      ..add(DiagnosticsProperty<ScrollController>(
        'controller',
        controller,
        showName: false,
        defaultValue: null,
      ))
      ..add(FlagProperty(
        'primary',
        value: primary,
        ifTrue: 'using primary controller',
        showName: true,
      ));
  }
}

class SizedScrollableAreaState extends State<SizedScrollableArea> {
  // GETTERS

  Axis get axis => widget.scrollDirection;

  ScrollController? get scrollController {
    final bool effectivePrimary = widget.primary ??
        widget.controller == null &&
            PrimaryScrollController.shouldInherit(
                context, widget.scrollDirection);

    final ScrollController? controller = effectivePrimary
        ? PrimaryScrollController.maybeOf(context)
        : widget.controller;

    return controller;
  }

  ScrollPosition? get position => scrollController?.position;
  ScrollBehavior get _configuration => context.scrollBehavior;
  ScrollPhysics get resolvedPhysics =>
      widget.physics?.applyTo(_configuration.getScrollPhysics(context)) ??
      _configuration.getScrollPhysics(context);

  /// The direction in which the widget scrolls.
  AxisDirection get axisDirection {
    return getAxisDirectionFromAxisReverseAndDirectionality(
      context,
      axis,
      widget.reverse,
    );
  }

  /// An [Offset] that represents the absolute distance from the origin, or 0,
  /// of the [ScrollPosition] expressed in the associated [Axis].
  ///
  /// Used by [EdgeDraggingAutoScroller] to progress the position forward when a
  /// drag gesture reaches the edge of the [Viewport].
  Offset? get deltaToScrollOrigin {
    final pos = position; // lint helper

    if (pos == null) return null;

    switch (axisDirection) {
      case AxisDirection.down:
        return Offset(0, pos.pixels);
      case AxisDirection.up:
        return Offset(0, -pos.pixels);
      case AxisDirection.left:
        return Offset(-pos.pixels, 0);
      case AxisDirection.right:
        return Offset(pos.pixels, 0);
    }
  }

  // DRAG HANDLERS

  double _scrollOffset(Offset offset) {
    final value =
        (widget.scrollDirection == Axis.vertical) ? offset.dy : offset.dx;

    return value * (widget.reverse ? -1 : 1);
  }

  GestureDragUpdateCallback? get _onVerticalDragUpdate =>
      widget.scrollDirection != Axis.vertical
          ? null
          : (details) {
              position?.moveTo(position!.pixels - _scrollOffset(details.delta));
            };

  GestureDragUpdateCallback? get _onHorizontalDragUpdate =>
      widget.scrollDirection != Axis.horizontal
          ? null
          : (details) {
              position?.moveTo(
                position!.pixels - _scrollOffset(details.delta),
              );
            };

  // SCROLL WHEEL HANDLERS

  /// Returns the offset that should result from applying [event] to the current
  /// position, taking min/max scroll extent into account.
  ///
  /// Return null if [position] is null.
  ///
  /// Copied from [Scrollable].
  double? _targetScrollOffsetForPointerScroll(double delta) {
    if (position == null) return null;

    return math.min(
      math.max(position!.pixels + delta, position!.minScrollExtent),
      position!.maxScrollExtent,
    );
  }

  /// Returns the delta that should result from applying [event] with axis,
  /// direction, and any modifiers specified by the ScrollBehavior taken into
  /// account.
  ///
  /// Copied from [Scrollable].
  double _pointerSignalEventDelta(PointerScrollEvent event) {
    late double delta;
    final Set<LogicalKeyboardKey> pressed =
        HardwareKeyboard.instance.logicalKeysPressed;
    final bool flipAxes = pressed
            .any(_configuration.pointerAxisModifiers.contains) &&
        // Axes are only flipped for physical mouse wheel input.
        // On some platforms, like web, trackpad input is handled through pointer
        // signals, but should not be included in this axis modifying behavior.
        // This is because on a trackpad, all directional axes are available to
        // the user, while mouse scroll wheels typically are restricted to one
        // axis.
        event.kind == PointerDeviceKind.mouse;

    switch (axis) {
      case Axis.horizontal:
        delta = flipAxes ? event.scrollDelta.dy : event.scrollDelta.dx;
      case Axis.vertical:
        delta = flipAxes ? event.scrollDelta.dx : event.scrollDelta.dy;
    }

    if (widget.reverse) {
      delta *= -1;
    }

    return delta;
  }

  /// Copied from [Scrollable].
  void _onPointerSignal(PointerSignalEvent event) {
    final pos = position; // lint helper

    if (event is PointerScrollEvent && pos != null) {
      if (!resolvedPhysics.shouldAcceptUserOffset(pos)) return;

      final double delta = _pointerSignalEventDelta(event);
      final double targetScrollOffset =
          _targetScrollOffsetForPointerScroll(delta)!;

      // Only express interest in the event if it would actually result in a scroll.
      if (delta != 0.0 && targetScrollOffset != pos.pixels) {
        GestureBinding.instance.pointerSignalResolver
            .register(event, _handlePointerScroll);
      }
    } else if (event is PointerScrollInertiaCancelEvent) {
      pos?.pointerScroll(0);
      // Don't use the pointer signal resolver, all hit-tested scrollables should stop.
    }
  }

  void _handlePointerScroll(PointerEvent event) {
    final pos = position; // lint helper

    if (pos == null) return;

    assert(event is PointerScrollEvent);
    final double delta = _pointerSignalEventDelta(event as PointerScrollEvent);
    final double targetScrollOffset =
        _targetScrollOffsetForPointerScroll(delta)!;
    if (delta != 0.0 && targetScrollOffset != pos.pixels) {
      pos.pointerScroll(delta);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Listener(
        onPointerSignal: _onPointerSignal,
        child: MouseRegion(
          child: GestureDetector(
            supportedDevices: context.scrollBehavior.dragDevices,
            onVerticalDragUpdate: _onVerticalDragUpdate,
            onHorizontalDragUpdate: _onHorizontalDragUpdate,
            child: widget.child,
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties
      ..add(DiagnosticsProperty<ScrollPosition>('position', position))
      ..add(DiagnosticsProperty('effective physics', resolvedPhysics));
  }
}
