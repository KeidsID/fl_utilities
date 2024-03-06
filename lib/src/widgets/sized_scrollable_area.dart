import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
/// ** See code in examples/widgets/lib/sized_scrollable_area.dart **
/// {@end-tool}
/// {@endtemplate}
class SizedScrollableArea extends StatelessWidget {
  /// {@macro fl_utils.src.widgets.SizedScrollableArea}
  const SizedScrollableArea({
    super.key,
    this.controller,
    this.primary,
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

  double _scrollOffset(Offset offset) {
    final value = (scrollDirection == Axis.vertical) ? offset.dy : offset.dx;

    return value * (reverse ? -1 : 1);
  }

  // ----------------------------------------------------------------------------
  // SCROLL WHEEL HANDLERS
  // ----------------------------------------------------------------------------

  PointerSignalEventListener _onPointerSignal(ScrollController? controller) {
    return (ev) {
      if (ev is PointerScrollEvent) {
        controller?.position.moveTo(
          controller.position.pixels + _scrollOffset(ev.scrollDelta),
        );
      } else if (ev is PointerScrollInertiaCancelEvent) {
        controller?.position.pointerScroll(0);
      }
    };
  }

  // ----------------------------------------------------------------------------
  // TOUCH HANDLERS
  // ----------------------------------------------------------------------------

  GestureDragUpdateCallback? _onVerticalDragUpdate(
    ScrollController? controller,
  ) {
    return scrollDirection != Axis.vertical
        ? null
        : (details) {
            controller?.position.moveTo(
              controller.position.pixels - _scrollOffset(details.delta),
            );
          };
  }

  GestureDragUpdateCallback? _onHorizontalDragUpdate(
    ScrollController? controller,
  ) {
    return scrollDirection != Axis.horizontal
        ? null
        : (details) {
            controller?.position.moveTo(
              controller.position.pixels - _scrollOffset(details.delta),
            );
          };
  }

  @override
  Widget build(BuildContext context) {
    final bool effectivePrimary = primary ??
        controller == null &&
            PrimaryScrollController.shouldInherit(context, scrollDirection);

    final ScrollController? scrollController = effectivePrimary
        ? PrimaryScrollController.maybeOf(context)
        : controller;

    return SizedBox(
      width: width,
      height: height,
      child: Listener(
        onPointerSignal: _onPointerSignal(scrollController),
        child: MouseRegion(
          // For mobile/mouse/trackpad drag.
          child: GestureDetector(
            onVerticalDragUpdate: _onVerticalDragUpdate(scrollController),
            onHorizontalDragUpdate: _onHorizontalDragUpdate(scrollController),
            child: child,
          ),
        ),
      ),
    );
  }
}
