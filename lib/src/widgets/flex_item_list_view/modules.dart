import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

part "libs/delegates.dart";
part 'libs/widgets.dart';

/// [FlexItemListView] signature function to build item on demand.
typedef NullableIndexedFlexItemListViewBuilder = FlexItemListViewItem? Function(
  BuildContext context,
  int index,
);

/// [FlexItemListView] signature function to build seperator.
typedef IndexedFlexItemListViewBuilder = FlexItemListViewItem Function(
  BuildContext context,
  int index,
);

/// {@template flu.widgets.FlexItemListView}
/// [ListView] with customizable items.
///
/// Unlike the [ListView] that force its children cross axis length to stretch,
/// this widget can manipulate the cross axis length of the item.
///
/// This widget is useful when you need to display a list of widgets with
/// different sizes, but still want to presist the scrollbar position.
///
/// ```dart
/// import "package:flutter/material.dart";
/// import "package:fl_utilities/fl_utilities.dart";
///
/// final myWidget = FlexItemListView(
///   // adjust default item delegate here
///   viewDelegate: FlexItemListViewDelegate(
///     mainAxisLength: 200.0,
///     crossAxisLength: 400.0,
///
///     // alignment can also be specified
///     crossAxisAlignment: FlexItemListViewAlignment.center,
///   ),
///   children: [
///     FlexItemListViewItem(
///       // overrides default
///       mainAxisLength: 400.0,
///       crossAxisLength: 200.0,
///       crossAxisAlignment: FlexItemListViewAlignment.start,
///       child: Text('Title'), // actual item that will be displayed
///     ),
///     FlexItemListViewItem(child: Card()),
///   ],
///   // Or you can do mapping for existing list of widgets.
///   // children: items.map((item) => FlexItemListViewItem(child: item)).toList(),
/// );
/// ```
///
/// See also:
/// - [FlexItemListViewItem], delegate to customize children.
/// - [FlexItemListViewDelegate], default delegate for the children.
/// - [Demo link](https://github.com/KeidsID/fl_utilities/blob/main/example/lib/src/widgets/custom_list_view.dart).
/// {@endtemplate}
class FlexItemListView extends ListView {
  /// {@macro flu.widgets.FlexItemListView}
  FlexItemListView({
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
    List<FlexItemListViewItem> children = const [],
    super.semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    this.viewDelegate = const FlexItemListViewDelegate(),
  }) : super(
          children: children.map((e) {
            return FlexItemListViewItemImpl(
              itemDelegate: e,
              viewDelegate: viewDelegate.copyWithViewDelegate(
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
  FlexItemListView.builder({
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
    required NullableIndexedFlexItemListViewBuilder itemBuilder,
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
    this.viewDelegate = const FlexItemListViewDelegate(),
  }) : super.builder(
          itemBuilder: (context, index) {
            final itemDelegate = itemBuilder(context, index);

            if (itemDelegate == null) return null;

            return FlexItemListViewItemImpl(
              itemDelegate: itemDelegate,
              viewDelegate: viewDelegate.copyWithViewDelegate(
                scrollDirection: scrollDirection,
                reverse: reverse,
                itemExtent: itemExtent,
                prototypeItem: prototypeItem,
              ),
            );
          },
        );

  /// This constructor is [FlexItemListView.builder] with a [separatorBuilder].
  /// The [separatorBuilder] is called between each item to separate them.
  FlexItemListView.separated({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    required NullableIndexedFlexItemListViewBuilder itemBuilder,
    super.findChildIndexCallback,
    required IndexedFlexItemListViewBuilder separatorBuilder,
    required super.itemCount,
    super.addAutomaticKeepAlives = true,
    super.addRepaintBoundaries = true,
    super.addSemanticIndexes = true,
    super.cacheExtent,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    this.viewDelegate = const FlexItemListViewDelegate(),
  }) : super.separated(
          itemBuilder: (context, index) {
            final delegate = itemBuilder(context, index);

            if (delegate == null) return null;

            return FlexItemListViewItemImpl(
              itemDelegate: delegate,
              viewDelegate: viewDelegate.copyWithViewDelegate(
                scrollDirection: scrollDirection,
                reverse: reverse,
              ),
            );
          },
          separatorBuilder: (context, index) => FlexItemListViewItemImpl(
            itemDelegate: separatorBuilder(context, index),
            viewDelegate: viewDelegate.copyWithViewDelegate(
              scrollDirection: scrollDirection,
              reverse: reverse,
            ),
          ),
        );

  /// [FlexItemListViewItem] default values.
  ///
  /// Use this instead applying same delegate for each item.
  final FlexItemListViewDelegate viewDelegate;
}
