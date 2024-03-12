import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// [CustomListView] signature function to build item on demand.
typedef NullableIndexedCustomListViewBuilder = CustomListViewItemDelegate?
    Function(
  BuildContext context,
  int index,
);

/// [CustomListView] signature function to build seperator.
typedef IndexedCustomListViewBuilder = CustomListViewItemDelegate Function(
  BuildContext context,
  int index,
);

/// {@template fl_utilities.widgets.CustomListView}
/// A custom [ListView].
///
/// Unlike the [ListView] that force its item cross axis to stretch, this widget
/// can manipulate the cross axis length of the item.
///
/// {@tool dartpad}
/// ** See code in example/lib/src/widgets/custom_list_view.dart **
/// {@end-tool}
///
/// See also:
/// - [CustomListViewItemDelegate], delegate to customize item.
/// {@endtemplate}
class CustomListView extends ListView {
  /// {@macro fl_utilities.widgets.CustomListView}
  CustomListView({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    super.itemExtent,
    super.prototypeItem,
    super.addAutomaticKeepAlives,
    super.addRepaintBoundaries,
    super.addSemanticIndexes,
    super.cacheExtent,
    List<CustomListViewItemDelegate> children = const [],
    super.semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    this.crossAxisAlignment = CustomListViewItemAlignment.center,
  }) : super(
          children: children.map((e) {
            return CustomListViewItem(
              delegate: e,
              crossAxisAlignment: crossAxisAlignment,
              scrollDirection: scrollDirection,
              reverse: reverse,
            );
          }).toList(),
        );

  /// {@macro fl_utilities.widgets.CustomListView}
  ///
  /// This constructor is appropriate for list views with a large (or infinite)
  /// number of children because the builder is called only for those children
  /// that are actually visible.
  CustomListView.builder({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    super.itemExtent,
    super.prototypeItem,
    required NullableIndexedCustomListViewBuilder itemBuilder,
    super.findChildIndexCallback,
    super.itemCount,
    super.addAutomaticKeepAlives = true,
    super.addRepaintBoundaries = true,
    super.addSemanticIndexes = true,
    super.cacheExtent,
    super.semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    this.crossAxisAlignment = CustomListViewItemAlignment.center,
  }) : super.builder(
          itemBuilder: (context, index) {
            final delegate = itemBuilder(context, index);

            if (delegate == null) return null;

            return CustomListViewItem(
              delegate: delegate,
              crossAxisAlignment: crossAxisAlignment,
              scrollDirection: scrollDirection,
              reverse: reverse,
            );
          },
        );

  /// {@macro fl_utilities.widgets.CustomListView}
  ///
  /// This constructor is [CustomListView.builder] with a [separatorBuilder].
  /// So each item will have a separator.
  CustomListView.separated({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    required NullableIndexedCustomListViewBuilder itemBuilder,
    super.findChildIndexCallback,
    required IndexedCustomListViewBuilder separatorBuilder,
    required super.itemCount,
    super.addAutomaticKeepAlives = true,
    super.addRepaintBoundaries = true,
    super.addSemanticIndexes = true,
    super.cacheExtent,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    this.crossAxisAlignment = CustomListViewItemAlignment.center,
  }) : super.separated(
          itemBuilder: (context, index) {
            final delegate = itemBuilder(context, index);

            if (delegate == null) return null;

            return CustomListViewItem(
              delegate: delegate,
              crossAxisAlignment: crossAxisAlignment,
              scrollDirection: scrollDirection,
              reverse: reverse,
            );
          },
          separatorBuilder: (context, index) => CustomListViewItem(
            delegate: separatorBuilder(context, index),
            crossAxisAlignment: crossAxisAlignment,
            scrollDirection: scrollDirection,
            reverse: reverse,
          ),
        );

  /// How the [CustomListView] children should be placed along the cross axis.
  ///
  /// Defaults to [CustomListViewItemAlignment.center].
  final CustomListViewItemAlignment crossAxisAlignment;
}

/// {@template fl_utilities.widgets.CustomListViewItemDelegate}
/// [CustomListView] children delegate.
///
/// With this you can manipulate the cross axis length of the item. Unlike
/// [ListView] that force its item cross axis length to stretch.
/// {@endtemplate}
class CustomListViewItemDelegate {
  /// {@macro fl_utilities.widgets.CustomListViewItemDelegate}
  const CustomListViewItemDelegate({
    this.key,
    this.mainAxisLength,
    this.crossAxisLength,
    this.crossAxisAlignment,
    this.child,
  }) : assert(mainAxisLength != double.infinity);

  /// {@macro fl_utilities.widgets.CustomListViewItemDelegate}
  ///
  /// This constructor will use [dimension] on both [mainAxisLength] and
  /// [crossAxisLength].
  const CustomListViewItemDelegate.square({
    this.key,
    double? dimension,
    this.crossAxisAlignment,
    this.child,
  })  : assert(dimension != double.infinity),
        mainAxisLength = dimension,
        crossAxisLength = dimension;

  /// [CustomListView] item key.
  final Key? key;

  /// The length of the item on the [CustomListView] main axis.
  ///
  /// If `null`, then use the [child] size constraint.
  ///
  /// `double.infinity` will throw [AssertionError].
  final double? mainAxisLength;

  /// The length of the item on the [CustomListView] cross axis.
  ///
  /// If `null`, the cross axis length will be stretched by default
  /// (same as `double.infinity`).
  final double? crossAxisLength;

  /// The cross axis alignment of the item.
  ///
  /// If `null`, then use [CustomListView.crossAxisAlignment] instead.
  final CustomListViewItemAlignment? crossAxisAlignment;

  /// The actual item widget to render.
  final Widget? child;
}

/// How the [CustomListView] children should be placed along the cross axis.
///
/// See also:
/// - [CustomListViewItemDelegate], delegate to manipulate [CustomListView] items.
enum CustomListViewItemAlignment {
  /// Place the children with their start edge aligned with the start side of
  /// the cross axis.
  ///
  /// Affected by [CustomListView.scrollDirection] and [CustomListView.reverse].
  start,

  /// Place the children to the end of the cross axis as possible.
  ///
  /// Affected by [CustomListView.scrollDirection] and [CustomListView.reverse].
  end,

  /// Place the children to the center of the cross axis.
  ///
  /// [CustomListViewItemDelegate.crossAxisAlignment] default value.
  center,

  /// Stretch the children to fill the cross axis.
  ///
  /// Will ignore [CustomListViewItemDelegate.crossAxisLength].
  stretch,
}

/// {@template fl_utilities.widgets.CustomListViewItem}
/// Widget implementation for [CustomListViewItemDelegate].
///
/// Not to be used directly.
/// {@endtemplate}
final class CustomListViewItem extends StatelessWidget {
  /// {@macro fl_utilities.widgets.CustomListViewItem}
  @protected
  @visibleForTesting
  CustomListViewItem({
    required this.delegate,
    required this.crossAxisAlignment,
    required this.scrollDirection,
    required this.reverse,
  }) : super(key: delegate.key);

  /// {@macro fl_utilities.widgets.CustomListViewItemDelegate}
  final CustomListViewItemDelegate delegate;

  /// The cross axis alignment of the item from [CustomListView].
  final CustomListViewItemAlignment crossAxisAlignment;

  /// The scroll direction of the [CustomListView].
  final Axis scrollDirection;

  /// Whether the [CustomListView] is reversed.
  final bool reverse;

  /// The cross axis alignment of the item.
  CustomListViewItemAlignment get _crossAxisAlignment =>
      delegate.crossAxisAlignment ?? crossAxisAlignment;

  /// The widget is stretched.
  bool get isStretch =>
      delegate.crossAxisLength == null ||
      _crossAxisAlignment == CustomListViewItemAlignment.stretch;

  /// Actual cross axis length that visible.
  double? get _crossAxisLength =>
      isStretch ? double.infinity : delegate.crossAxisLength;

  /// The widget width.
  double? get width => _isVertical ? _crossAxisLength : delegate.mainAxisLength;

  /// The widget height.
  double? get height => _isVertical ? delegate.mainAxisLength : _crossAxisLength;

  /// Scroll direction is vertical.
  bool get _isVertical => scrollDirection == Axis.vertical;

  @override
  Widget build(BuildContext context) {
    final crossAxisDirection = getAxisDirectionFromAxisReverseAndDirectionality(
      context,
      flipAxis(scrollDirection),
      reverse,
    );

    return Container(
      width: !_isVertical ? delegate.mainAxisLength : null,
      height: _isVertical ? delegate.mainAxisLength : null,
      alignment: switch (_crossAxisAlignment) {
        CustomListViewItemAlignment.start => switch (crossAxisDirection) {
            AxisDirection.down => Alignment.topCenter,
            AxisDirection.up => Alignment.bottomCenter,
            AxisDirection.right => Alignment.centerLeft,
            AxisDirection.left => Alignment.centerRight,
          },
        CustomListViewItemAlignment.end => switch (crossAxisDirection) {
            AxisDirection.down => Alignment.bottomCenter,
            AxisDirection.up => Alignment.topCenter,
            AxisDirection.right => Alignment.centerRight,
            AxisDirection.left => Alignment.centerLeft,
          },
        _ => Alignment.center,
      },
      child: isStretch
          ? delegate.child
          : SizedBox(
              width: _isVertical ? delegate.crossAxisLength : null,
              height: !_isVertical ? delegate.crossAxisLength : null,
              child: delegate.child,
            ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties
      ..add(DoubleProperty('width', width, defaultValue: null))
      ..add(DoubleProperty('height', height, defaultValue: null))
      ..add(EnumProperty<CustomListViewItemAlignment>(
        'crossAxisAlignment',
        _crossAxisAlignment,
        defaultValue: CustomListViewItemAlignment.center,
        level: isStretch ? DiagnosticLevel.hidden : DiagnosticLevel.info,
      ));
  }
}
