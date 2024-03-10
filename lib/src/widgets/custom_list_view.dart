import 'package:flutter/material.dart';

/// [CustomListView.builder] signature function to build item.
typedef CustomListViewBuilder = CustomListViewItemDelegate? Function(
  BuildContext context,
  int index,
);

/// {@template fl_utilities.src.widgets.CustomListView}
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
class CustomListView extends CustomScrollView {
  /// {@macro fl_utilities.src.widgets.CustomListView}
  CustomListView({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.scrollBehavior,
    super.shrinkWrap,
    super.center,
    super.anchor,
    super.cacheExtent,
    super.semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    List<CustomListViewItemDelegate> children = const [],
  }) : super(
          slivers: [
            SliverList.list(
              addAutomaticKeepAlives: addAutomaticKeepAlives,
              addRepaintBoundaries: addRepaintBoundaries,
              addSemanticIndexes: addSemanticIndexes,
              children: children.map((e) {
                return _itemBuild(e, scrollDirection, reverse);
              }).toList(),
            ),
          ],
        );

  /// {@macro fl_utilities.src.widgets.CustomListView}
  ///
  /// This constructor is appropriate for sliver lists with a large
  /// (or infinite) number of children because the builder is called only for
  /// those children that are actually visible.
  CustomListView.builder({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.scrollBehavior,
    super.shrinkWrap,
    super.center,
    super.anchor,
    super.cacheExtent,
    super.semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    int? itemCount,
    required CustomListViewBuilder itemBuilder,
  }) : super(
          slivers: [
            SliverList.builder(
              addAutomaticKeepAlives: addAutomaticKeepAlives,
              addRepaintBoundaries: addRepaintBoundaries,
              addSemanticIndexes: addSemanticIndexes,
              itemCount: itemCount,
              itemBuilder: (context, index) {
                final delegate = itemBuilder(context, index);

                if (delegate == null) return null;

                return _itemBuild(delegate, scrollDirection, reverse);
              },
            ),
          ],
        );

  /// {@macro flutter.widgets.SliverChildBuilderDelegate.addAutomaticKeepAlives}
  final bool addAutomaticKeepAlives;

  /// {@macro flutter.widgets.SliverChildBuilderDelegate.addRepaintBoundaries}
  final bool addRepaintBoundaries;

  /// {@macro flutter.widgets.SliverChildBuilderDelegate.addSemanticIndexes}
  final bool addSemanticIndexes;

  static Widget _itemBuild(
    CustomListViewItemDelegate delegate,
    Axis scrollDirection,
    bool reverse,
  ) {
    final isVert = scrollDirection == Axis.vertical;

    return SizedBox(
      width: !isVert ? delegate.mainAxisLength : null,
      height: isVert ? delegate.mainAxisLength : null,
      child: delegate.crossAxisAlignment == CustomListViewItemAlignment.stretch
          ? delegate.child
          : Builder(builder: (context) {
              final crossAxisDirection =
                  getAxisDirectionFromAxisReverseAndDirectionality(
                context,
                flipAxis(scrollDirection),
                reverse,
              );

              final Alignment startAlignment = switch (crossAxisDirection) {
                AxisDirection.down => Alignment.topCenter,
                AxisDirection.up => Alignment.bottomCenter,
                AxisDirection.right => Alignment.centerLeft,
                AxisDirection.left => Alignment.centerRight,
              };

              final Alignment endAlignment = switch (crossAxisDirection) {
                AxisDirection.down => Alignment.bottomCenter,
                AxisDirection.up => Alignment.topCenter,
                AxisDirection.right => Alignment.centerRight,
                AxisDirection.left => Alignment.centerLeft,
              };

              return Align(
                alignment: switch (delegate.crossAxisAlignment) {
                  CustomListViewItemAlignment.start => startAlignment,
                  CustomListViewItemAlignment.end => endAlignment,
                  _ => Alignment.center,
                },
                child: SizedBox(
                  width: isVert ? delegate.crossAxisLength : null,
                  height: !isVert ? delegate.crossAxisLength : null,
                  child: delegate.child,
                ),
              );
            }),
    );
  }
}

/// {@template fl_utilities.src.widgets.CustomListViewItemDelegate}
/// The delegate of [CustomListView] item.
///
/// With this you can manipulate the cross axis length of the item. Unlike
/// [ListView] that force its item cross axis length to stretch.
/// {@endtemplate}
class CustomListViewItemDelegate {
  /// {@macro fl_utilities.src.widgets.CustomListViewItemDelegate}
  const CustomListViewItemDelegate({
    this.mainAxisLength,
    this.crossAxisLength,
    this.crossAxisAlignment = CustomListViewItemAlignment.center,
    this.child,
  });

  /// {@macro fl_utilities.src.widgets.CustomListViewItemDelegate}
  ///
  /// This constructor will use [dimension] on both [mainAxisLength] and
  /// [crossAxisLength].
  const CustomListViewItemDelegate.square({
    double? dimension,
    this.crossAxisAlignment = CustomListViewItemAlignment.center,
    this.child,
  })  : mainAxisLength = dimension,
        crossAxisLength = dimension;

  /// The length of the item on the [CustomListView] main axis.
  ///
  /// If `null`, then use the [child] size constraint.
  final double? mainAxisLength;

  /// The length of the item on the [CustomListView] cross axis.
  ///
  /// If `null`, the cross axis length will be stretched by default.
  final double? crossAxisLength;

  /// The cross axis alignment of the item.
  final CustomListViewItemAlignment crossAxisAlignment;

  /// The actual item widget to render.
  final Widget? child;
}

/// How the [CustomListView] items should be placed along the cross axis.
///
/// See also:
/// - [CustomListViewItemDelegate], delegate to manipulate [CustomListView] items.
enum CustomListViewItemAlignment {
  /// Place the items with their start edge aligned with the start side of
  /// the cross axis.
  ///
  /// Affected by [CustomListView.scrollDirection] and [CustomListView.reverse].
  start,

  /// Place the items to the end of the cross axis as possible.
  ///
  /// Affected by [CustomListView.scrollDirection] and [CustomListView.reverse].
  end,

  /// Place the items to the center of the cross axis.
  center,

  /// Stretch the item to fill the cross axis.
  ///
  /// Will ignore [CustomListViewItemDelegate.crossAxisLength].
  stretch,
}
