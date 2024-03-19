import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// [CustomListView] signature function to build item on demand.
typedef NullableIndexedCustomListViewBuilder = CustomListViewItemDelegate?
    Function(BuildContext context, int index);

/// [CustomListView] signature function to build seperator.
typedef IndexedCustomListViewBuilder = CustomListViewItemDelegate Function(
    BuildContext context, int index);

/// {@template fl_utilities.widgets.CustomListView}
/// A custom [ListView].
///
/// Unlike the [ListView] that force its children cross axis length to stretch,
/// this widget can manipulate the cross axis length of the item.
///
/// {@tool dartpad}
/// ** See code in example/lib/src/widgets/custom_list_view.dart **
/// {@end-tool}
///
/// See also:
/// - [CustomListViewItemDelegate], delegate to customize children.
/// - [CustomListViewDelegate], default delegate for the children.
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
    this.viewDelegate,
  }) : super(
          children: children.map((e) {
            return CustomListViewItem(
              itemDelegate: e,
              viewDelegate: viewDelegate?.copyWithViewDelegate(
                    scrollDirection: scrollDirection,
                    reverse: reverse,
                    itemExtent: itemExtent,
                    prototypeItem: prototypeItem,
                  ) ??
                  const CustomListViewDelegate().copyWithViewDelegate(
                    crossAxisAlignment: crossAxisAlignment,
                    scrollDirection: scrollDirection,
                    reverse: reverse,
                    itemExtent: itemExtent,
                    prototypeItem: prototypeItem,
                  ),
            );
          }).toList(),
        );

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
    this.viewDelegate,
  }) : super.builder(
          itemBuilder: (context, index) {
            final itemDelegate = itemBuilder(context, index);

            if (itemDelegate == null) return null;

            return CustomListViewItem(
              itemDelegate: itemDelegate,
              viewDelegate: viewDelegate?.copyWithViewDelegate(
                    scrollDirection: scrollDirection,
                    reverse: reverse,
                    itemExtent: itemExtent,
                    prototypeItem: prototypeItem,
                  ) ??
                  const CustomListViewDelegate().copyWithViewDelegate(
                    crossAxisAlignment: crossAxisAlignment,
                    scrollDirection: scrollDirection,
                    reverse: reverse,
                    itemExtent: itemExtent,
                    prototypeItem: prototypeItem,
                  ),
            );
          },
        );

  /// This constructor is [CustomListView.builder] with a [separatorBuilder].
  /// The [separatorBuilder] is called between each item to separate them.
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
    this.viewDelegate,
  }) : super.separated(
          itemBuilder: (context, index) {
            final delegate = itemBuilder(context, index);

            if (delegate == null) return null;

            return CustomListViewItem(
              itemDelegate: delegate,
              viewDelegate: viewDelegate?.copyWithViewDelegate(
                    scrollDirection: scrollDirection,
                    reverse: reverse,
                  ) ??
                  const CustomListViewDelegate().copyWithViewDelegate(
                    crossAxisAlignment: crossAxisAlignment,
                    scrollDirection: scrollDirection,
                    reverse: reverse,
                  ),
            );
          },
          separatorBuilder: (context, index) => CustomListViewItem(
            itemDelegate: separatorBuilder(context, index),
            viewDelegate: viewDelegate?.copyWithViewDelegate(
                  scrollDirection: scrollDirection,
                  reverse: reverse,
                ) ??
                const CustomListViewDelegate().copyWithViewDelegate(
                  crossAxisAlignment: crossAxisAlignment,
                  scrollDirection: scrollDirection,
                  reverse: reverse,
                ),
          ),
        );

  /// How the [CustomListView] children should be placed along the cross axis.
  ///
  /// Defaults to [CustomListViewItemAlignment.center].
  @Deprecated(
    'Use viewDelegate instead. '
    'This feature will be removed in the next major version',
  )
  final CustomListViewItemAlignment crossAxisAlignment;

  /// [CustomListViewItemDelegate] default values.
  ///
  /// Use this instead applying same delegate for each item.
  // TODO: non null on the next major version
  final CustomListViewDelegate? viewDelegate;
}

/// [CustomListViewItem] delegate base.
abstract base class _CustomListViewItemDelegate {
  const _CustomListViewItemDelegate({
    this.mainAxisLength,
    this.crossAxisLength,
  }) : assert(mainAxisLength != double.infinity);

  /// {@template fl_utilities.widgets.CustomListViewItemDelegate.square}
  /// This constructor will use [dimension] on both [mainAxisLength] and
  /// [crossAxisLength].
  /// {@endtemplate}
  const _CustomListViewItemDelegate.square({
    double? dimension,
  })  : assert(dimension != double.infinity),
        mainAxisLength = dimension,
        crossAxisLength = dimension;

  /// The length of the item on the [CustomListView] main axis.
  ///
  /// Default value is [CustomListViewDelegate.mainAxisLength].
  ///
  /// If the default value is `null`, then [CustomListViewItemDelegate.child]
  /// constraints will be used instead.
  ///
  /// `double.infinity` will throw an [AssertionError].
  ///
  /// If [CustomListView.itemExtent] or [CustomListView.prototypeItem]
  /// is not `null`, the item will ignore this.
  final double? mainAxisLength;

  /// The length of the item on the [CustomListView] cross axis.
  ///
  /// Default value is [CustomListViewDelegate.crossAxisLength].
  ///
  /// If the default value is `null`, the cross axis length will be stretched
  /// by default (same as `double.infinity`).
  final double? crossAxisLength;

  /// The cross axis alignment of the item.
  ///
  /// If `null`, then [CustomListViewDelegate.crossAxisAlignment] will be used
  /// instead.
  CustomListViewItemAlignment? get crossAxisAlignment;
}

/// How the [CustomListView] children should be placed along the cross axis.
///
/// See also:
/// - [CustomListViewItemDelegate], delegate to manipulate [CustomListView] items.
/// - [CustomListViewDelegate], act as default item delegate values.
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
  /// Default value on [CustomListViewDelegate.crossAxisAlignment].
  center,

  /// Stretch the children to fill the cross axis.
  ///
  /// Will ignore delegate `crossAxisLength`.
  stretch,
}

/// {@template fl_utilities.widgets.CustomListViewItemDelegate}
/// [CustomListView] children delegate.
///
/// With this you can manipulate the cross axis length of the item. Unlike
/// [ListView] that force its item cross axis length to stretch.
///
/// [CustomListView.viewDelegate] will be used as interface default.
///
/// See also:
/// - [CustomListViewDelegate], default values for this delegate.
/// {@endtemplate}
final class CustomListViewItemDelegate extends _CustomListViewItemDelegate {
  /// {@macro fl_utilities.widgets.CustomListViewItemDelegate}
  const CustomListViewItemDelegate({
    this.key,
    super.mainAxisLength,
    super.crossAxisLength,
    this.crossAxisAlignment,
    this.child,
  });

  /// {@macro fl_utilities.widgets.CustomListViewItemDelegate.square}
  const CustomListViewItemDelegate.square({
    this.key,
    super.dimension,
    this.crossAxisAlignment,
    this.child,
  }) : super.square();

  /// [CustomListView] item key.
  final Key? key;

  @override
  final CustomListViewItemAlignment? crossAxisAlignment;

  /// The actual item widget to render.
  final Widget? child;
}

/// {@template fl_utilities.widgets.CustomListViewDelegate}
/// Used as [CustomListViewItemDelegate] default values.
///
/// Use this instead applying delegate values for each item.
/// {@endtemplate}
final class CustomListViewDelegate extends _CustomListViewItemDelegate {
  /// {@macro fl_utilities.widgets.CustomListViewDelegate}
  const CustomListViewDelegate({
    super.mainAxisLength,
    super.crossAxisLength,
    this.crossAxisAlignment = CustomListViewItemAlignment.center,
  })  : scrollDirection = Axis.vertical,
        reverse = false,
        itemExtent = null,
        prototypeItem = null;

  /// {@macro fl_utilities.widgets.CustomListViewItemDelegate.square}
  const CustomListViewDelegate.square({
    super.dimension,
    this.crossAxisAlignment = CustomListViewItemAlignment.center,
  })  : scrollDirection = Axis.vertical,
        reverse = false,
        itemExtent = null,
        prototypeItem = null,
        super.square();

  const CustomListViewDelegate._({
    super.mainAxisLength,
    super.crossAxisLength,
    this.crossAxisAlignment = CustomListViewItemAlignment.center,

    //
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.itemExtent,
    this.prototypeItem,
  }) : assert(
          itemExtent == null || prototypeItem == null,
          'You can only pass itemExtent or prototypeItem, not both.',
        );

  // ---------------------------------------------------------------------------
  // ITEM DELEGATE
  // ---------------------------------------------------------------------------

  @override
  final CustomListViewItemAlignment crossAxisAlignment;

  // ---------------------------------------------------------------------------
  // ACTUAL VIEW DELEGATE
  // ---------------------------------------------------------------------------

  /// [CustomListView.scrollDirection].
  final Axis scrollDirection;

  /// [CustomListView.reverse].
  final bool reverse;

  /// [CustomListView.itemExtent].
  final double? itemExtent;

  /// [CustomListView.prototypeItem].
  final Widget? prototypeItem;

  /// Creates a copy of this object but with the given fields replaced.
  ///
  /// Only to be used by [CustomListView] constructors.
  @protected
  @visibleForTesting
  CustomListViewDelegate copyWithViewDelegate({
    // TODO: remove [crossAxisAlignment] args on the next major version
    CustomListViewItemAlignment? crossAxisAlignment,
    Axis? scrollDirection,
    bool? reverse,
    double? itemExtent,
    Widget? prototypeItem,
  }) {
    return CustomListViewDelegate._(
      mainAxisLength: mainAxisLength,
      crossAxisLength: crossAxisLength,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      scrollDirection: scrollDirection ?? this.scrollDirection,
      reverse: reverse ?? this.reverse,
      itemExtent: itemExtent ?? this.itemExtent,
      prototypeItem: prototypeItem ?? this.prototypeItem,
    );
  }
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
    required this.itemDelegate,
    required this.viewDelegate,
  }) : super(key: itemDelegate.key);

  /// {@macro fl_utilities.widgets.CustomListViewItemDelegate}
  final CustomListViewItemDelegate itemDelegate;

  /// {@macro fl_utilities.widgets.CustomListViewDelegate}
  final CustomListViewDelegate viewDelegate;

  // ---------------------------------------------------------------------------
  // DELEGATES GETTERS
  // ---------------------------------------------------------------------------

  double? get _mainAxisLength => isExtended
      ? viewDelegate.itemExtent
      : itemDelegate.mainAxisLength ?? viewDelegate.mainAxisLength;

  double? get _crossAxisLength =>
      itemDelegate.crossAxisLength ?? viewDelegate.crossAxisLength;

  /// The cross axis alignment of the item.
  CustomListViewItemAlignment get crossAxisAlignment =>
      itemDelegate.crossAxisAlignment ?? viewDelegate.crossAxisAlignment;

  // ---------------------------------------------------------------------------
  // WIDGET GETTERS
  // ---------------------------------------------------------------------------

  /// The item `mainAxisLength` is extended.
  ///
  /// So the item will forced to extend by [CustomListView.itemExtent] or
  /// [CustomListView.prototypeItem] `mainAxisLength`.
  ///
  /// `crossAxisLength` won't be ignored, refer to [isStretch].
  bool get isExtended =>
      viewDelegate.itemExtent != null || viewDelegate.prototypeItem != null;

  /// Actual cross axis length that visible.
  double? get crossAxisLength => isStretch ? double.infinity : _crossAxisLength;

  /// The widget is stretched.
  ///
  /// Will ignore `crossAxisLength` from delegates.
  bool get isStretch =>
      _crossAxisLength == null ||
      crossAxisAlignment == CustomListViewItemAlignment.stretch;

  /// The widget width.
  double? get width => _isVertical ? crossAxisLength : _mainAxisLength;

  /// The widget height.
  double? get height => _isVertical ? _mainAxisLength : crossAxisLength;

  /// Scroll direction is vertical.
  bool get _isVertical => viewDelegate.scrollDirection == Axis.vertical;

  @override
  Widget build(BuildContext context) {
    final crossAxisDirection = getAxisDirectionFromAxisReverseAndDirectionality(
      context,
      flipAxis(viewDelegate.scrollDirection),
      viewDelegate.reverse,
    );

    return Container(
      width: !_isVertical ? _mainAxisLength : null,
      height: _isVertical ? _mainAxisLength : null,
      alignment: switch (crossAxisAlignment) {
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
          ? itemDelegate.child
          : SizedBox(
              width: _isVertical ? _crossAxisLength : null,
              height: !_isVertical ? _crossAxisLength : null,
              child: itemDelegate.child,
            ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties
      ..add(FlagProperty(
        'isExtended',
        value: isExtended,
        ifTrue: 'extended by "${viewDelegate.itemExtent ?? 'Widget'}"',
        ifFalse: 'not extended',
        level: isExtended ? DiagnosticLevel.info : DiagnosticLevel.hidden,
      ))
      ..add(DoubleProperty('width', width, defaultValue: null))
      ..add(DoubleProperty('height', height, defaultValue: null))
      ..add(EnumProperty<CustomListViewItemAlignment>(
        'crossAxisAlignment',
        crossAxisAlignment,
        defaultValue: CustomListViewItemAlignment.center,
        level: isStretch ? DiagnosticLevel.hidden : DiagnosticLevel.info,
      ));
  }
}
