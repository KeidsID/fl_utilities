part of "../modules.dart";

/// {@template flu.widgets.FlexItemListViewItem}
/// Widget implementation of [FlexItemListViewItem].
///
/// Not to be used directly.
/// {@endtemplate}
final class FlexItemListViewItemImpl extends StatelessWidget {
  /// {@macro flu.widgets.FlexItemListViewItem}
  @protected
  @visibleForTesting
  FlexItemListViewItemImpl({
    required this.itemDelegate,
    required this.viewDelegate,
  }) : super(key: itemDelegate.key);

  /// {@macro flu.widgets.FlexItemListViewItemDelegate}
  final FlexItemListViewItem itemDelegate;

  /// {@macro flu.widgets.FlexItemListViewDelegate}
  final FlexItemListViewDelegate viewDelegate;

  // DELEGATES GETTERS

  double? get _mainAxisLength => isExtended
      ? viewDelegate.itemExtent
      : itemDelegate.mainAxisLength ?? viewDelegate.mainAxisLength;

  double? get _crossAxisLength =>
      itemDelegate.crossAxisLength ?? viewDelegate.crossAxisLength;

  /// The cross axis alignment of the item.
  FlexItemListViewAlignment get crossAxisAlignment =>
      itemDelegate.crossAxisAlignment ?? viewDelegate.crossAxisAlignment;

  // WIDGET GETTERS

  /// The item `mainAxisLength` is extended.
  ///
  /// So the item will forced to extend by [FlexItemListView.itemExtent] or
  /// [FlexItemListView.prototypeItem] `mainAxisLength`.
  ///
  /// `crossAxisLength` won't be ignored, refer to [isStretch].
  bool get isExtended =>
      viewDelegate.itemExtent != null || viewDelegate.prototypeItem != null;

  /// The widget is stretched.
  ///
  /// Will ignore `crossAxisLength` from delegates.
  bool get isStretch =>
      _crossAxisLength == null ||
      crossAxisAlignment == FlexItemListViewAlignment.stretch;

  /// Scroll direction is vertical.
  bool get _isVertical => viewDelegate.scrollDirection == Axis.vertical;

  /// Actual cross axis length that visible.
  ///
  /// For debug purposes.
  double? get _dCrossAxisLength =>
      isStretch ? double.infinity : _crossAxisLength;

  /// The widget width.
  double? get width => _isVertical ? _dCrossAxisLength : _mainAxisLength;

  /// The widget height.
  double? get height => _isVertical ? _mainAxisLength : _dCrossAxisLength;

  @override
  Widget build(BuildContext context) {
    final alignmentOpposite = getAxisDirectionFromAxisReverseAndDirectionality(
      context,
      flipAxis(viewDelegate.scrollDirection),
      viewDelegate.reverse,
    );

    return Container(
      width: !_isVertical ? _mainAxisLength : null,
      height: _isVertical ? _mainAxisLength : null,
      alignment: switch (crossAxisAlignment) {
        FlexItemListViewAlignment.start => switch (alignmentOpposite) {
            AxisDirection.down => Alignment.topCenter,
            AxisDirection.up => Alignment.bottomCenter,
            AxisDirection.right => Alignment.centerLeft,
            AxisDirection.left => Alignment.centerRight,
          },
        FlexItemListViewAlignment.end => switch (alignmentOpposite) {
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
        defaultValue: false,
        ifTrue: 'extended by "${viewDelegate.itemExtent ?? 'Widget'}"',
        ifFalse: 'not extended',
        level: isExtended ? DiagnosticLevel.info : DiagnosticLevel.hidden,
      ))
      ..add(DoubleProperty('width', width, defaultValue: null))
      ..add(DoubleProperty('height', height, defaultValue: null))
      ..add(EnumProperty<FlexItemListViewAlignment>(
        'crossAxisAlignment',
        crossAxisAlignment,
        defaultValue: FlexItemListViewAlignment.center,
        level: isStretch ? DiagnosticLevel.hidden : DiagnosticLevel.info,
      ));
  }
}
