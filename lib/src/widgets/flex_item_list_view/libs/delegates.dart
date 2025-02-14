part of "../modules.dart";

/// [FlexItemListViewItemImpl] delegate base.
abstract base class _FlexItemListViewItemDelegate {
  const _FlexItemListViewItemDelegate({
    this.mainAxisLength,
    this.crossAxisLength,
  }) : assert(mainAxisLength != double.infinity);

  /// {@template fl_utilities.widgets.FlexItemListViewItemDelegate.square}
  /// This constructor will use [dimension] on both [mainAxisLength] and
  /// [crossAxisLength].
  /// {@endtemplate}
  const _FlexItemListViewItemDelegate.square({
    double? dimension,
  })  : assert(dimension != double.infinity),
        mainAxisLength = dimension,
        crossAxisLength = dimension;

  /// The length of the item on the [FlexItemListView] main axis.
  ///
  /// Default value is [FlexItemListViewDelegate.mainAxisLength].
  ///
  /// If the default value is `null`, then [FlexItemListViewItem.child]
  /// constraints will be used instead.
  ///
  /// `double.infinity` will throw an [AssertionError].
  ///
  /// If [FlexItemListView.itemExtent] or [FlexItemListView.prototypeItem]
  /// is not `null`, the item will ignore this.
  final double? mainAxisLength;

  /// The length of the item on the [FlexItemListView] cross axis.
  ///
  /// Default value is [FlexItemListViewDelegate.crossAxisLength].
  ///
  /// If the default value is `null`, the cross axis length will be stretched
  /// by default (same as `double.infinity`).
  final double? crossAxisLength;

  /// The cross axis alignment of the item.
  ///
  /// If `null`, then [FlexItemListViewDelegate.crossAxisAlignment] will be used
  /// instead.
  FlexItemListViewAlignment? get crossAxisAlignment =>
      throw UnimplementedError();
}

/// How the [FlexItemListView] children should be placed along the cross axis.
enum FlexItemListViewAlignment {
  /// Place the children to the start of the cross axis.
  ///
  /// Affected by [FlexItemListView.reverse].
  start,

  /// Place the children to the end of the cross axis as possible.
  ///
  /// Affected by [FlexItemListView.reverse].
  end,

  /// Place the children to the center of the cross axis.
  ///
  /// Default value on [FlexItemListViewDelegate.crossAxisAlignment].
  center,

  /// Stretch the children to fill the cross axis.
  ///
  /// Will ignore delegate `crossAxisLength`.
  stretch,
}

/// {@template fl_utilities.widgets.FlexItemListViewItemDelegate}
/// [FlexItemListView] children delegate.
///
/// See also:
/// - [FlexItemListViewDelegate], default values for this delegate.
/// {@endtemplate}
final class FlexItemListViewItem extends _FlexItemListViewItemDelegate {
  /// {@macro fl_utilities.widgets.FlexItemListViewItemDelegate}
  const FlexItemListViewItem({
    this.key,
    super.mainAxisLength,
    super.crossAxisLength,
    this.crossAxisAlignment,
    this.child,
  });

  /// {@macro fl_utilities.widgets.FlexItemListViewItemDelegate.square}
  const FlexItemListViewItem.square({
    this.key,
    super.dimension,
    this.crossAxisAlignment,
    this.child,
  }) : super.square();

  /// [FlexItemListView] item key.
  final Key? key;

  @override
  final FlexItemListViewAlignment? crossAxisAlignment;

  /// The actual item widget to render.
  final Widget? child;
}

/// {@template fl_utilities.widgets.FlexItemListViewDelegate}
/// Used as [FlexItemListView] default items delegate .
///
/// Use this instead applying delegate values for each item.
/// {@endtemplate}
final class FlexItemListViewDelegate extends _FlexItemListViewItemDelegate {
  /// {@macro fl_utilities.widgets.FlexItemListViewDelegate}
  const FlexItemListViewDelegate({
    super.mainAxisLength,
    super.crossAxisLength,
    this.crossAxisAlignment = FlexItemListViewAlignment.center,
  })  : scrollDirection = Axis.vertical,
        reverse = false,
        itemExtent = null,
        prototypeItem = null;

  /// {@macro fl_utilities.widgets.FlexItemListViewItemDelegate.square}
  const FlexItemListViewDelegate.square({
    super.dimension,
    this.crossAxisAlignment = FlexItemListViewAlignment.center,
  })  : scrollDirection = Axis.vertical,
        reverse = false,
        itemExtent = null,
        prototypeItem = null,
        super.square();

  const FlexItemListViewDelegate._({
    super.mainAxisLength,
    super.crossAxisLength,
    this.crossAxisAlignment = FlexItemListViewAlignment.center,

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
  final FlexItemListViewAlignment crossAxisAlignment;

  // ---------------------------------------------------------------------------
  // ACTUAL VIEW DELEGATE
  // ---------------------------------------------------------------------------

  /// [FlexItemListView.scrollDirection].
  final Axis scrollDirection;

  /// [FlexItemListView.reverse].
  final bool reverse;

  /// [FlexItemListView.itemExtent].
  final double? itemExtent;

  /// [FlexItemListView.prototypeItem].
  final Widget? prototypeItem;

  /// Creates a copy of this object but with the given fields replaced.
  ///
  /// Only to be used by [FlexItemListView] constructors.
  @protected
  @visibleForTesting
  FlexItemListViewDelegate copyWithViewDelegate({
    Axis? scrollDirection,
    bool? reverse,
    double? itemExtent,
    Widget? prototypeItem,
  }) {
    return FlexItemListViewDelegate._(
      mainAxisLength: mainAxisLength,
      crossAxisLength: crossAxisLength,
      crossAxisAlignment: crossAxisAlignment,
      scrollDirection: scrollDirection ?? this.scrollDirection,
      reverse: reverse ?? this.reverse,
      itemExtent: itemExtent ?? this.itemExtent,
      prototypeItem: prototypeItem ?? this.prototypeItem,
    );
  }
}
