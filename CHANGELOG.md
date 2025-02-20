# Changelog

## [3.0.0](https://github.com/KeidsID/fl_utilities/compare/fl_utilities-v2.0.1...fl_utilities-v3.0.0) (2025-02-20)

### ⚠ BREAKING CHANGES

* refactor!: remove [DialogPage] and [usePathUrlStrategy] since its not part of flutter SDK

* refactor!: rename [CustomListView] into [FlexItemListView]

  Functionality and API still same as the old one, only the name is changed and deprecated props are removed.

  ```dart
  import "package:flutter/material.dart";
  import "package:fl_utilities/fl_utilities.dart";
  
  final myWidget = FlexItemListView(
    // adjust default item delegate here
    viewDelegate: FlexItemListViewDelegate(
      mainAxisLength: 200.0,
      crossAxisLength: 400.0,
  
      // alignment can also be specified
      crossAxisAlignment: FlexItemListViewAlignment.center,
    ),
    children: [
      FlexItemListViewItem(
        // overrides default
        mainAxisLength: 400.0,
        crossAxisLength: 200.0,
        crossAxisAlignment: FlexItemListViewAlignment.start,
        child: Text('Title'), // actual item that will be displayed
      ),
      FlexItemListViewItem(child: Card()),
    ],
    // Or you can do mapping for existing list of widgets.
    // children: items.map((item) => FlexItemListViewItem(child: item)).toList(),
  );
  
  ```

* feat: add `MediaQuery.<prop>Of` shorthands on [BuildContext]

  So instead of `context.mediaQuery.size`, now you can do `context.mediaSize`

* refactor: update SDK constraints

* docs: add docs.page

* chore: add github templates

## 2.0.1

* feat: `CustomListViewDelegate`, default item delegate for the `CustomListView`
  children. Used on `CustomListView.viewDelegate`.
* _deprecated_: `CustomListView.crossAxisAlignment`, is now deprecated in favor of
  `CustomListView.viewDelegate`.

  Instead of:

  ```dart
  CustomListView(
    crossAxisAlignment: CustomListViewItemAlignment.end,
  );
  ```

  Do:

  ```dart
  CustomListView(
    viewDelegate: CustomListViewDelegate(
      crossAxisAlignment: CustomListViewItemAlignment.end,
      // can also specify other [CustomListViewItemDelegate] values
      // mainAxisLength: 80.0,
      // crossAxisLength: 80.0,
    ),
  );
  ```

## 2.0.0

### Added

* `CustomListView], a custom`ListView` with customizeable children.
* `CustomListViewItemDelegate`, delegate to customize `CustomListView` item.
* `CustomListViewItemAlignment`, an enum to control item cross axis alignment of

  `CustomListView`.

* `CustomListViewItem`, a widget implementation for
  `CustomListViewItemDelegate`, not to be used directly.

### Removed

* `SizedScrollableArea`

### Breaking Changes

The main reason why `SizedScrollableArea` exist because there's some cases that
we need to modify the `ListView` item cross axis length, but we still wanted the
scroll area fill the whole screen.

But why replace `SizedScrollableArea` with `CustomListView`?

* The `SizedScrollableArea` widget is too verbose (Need same controller to
  control scroll).
* The `CustomListView` widget is more flexible because it just a `ListView` with
  some extra features (such as manipulate cross axis length).
* And actually `SizedScrollableArea` is not stable yet (too much bugs).

### Migrate Guide

* `SizedScrollableArea` -> `CustomListView`

  Before:

  ```dart
  PrimaryScrollController(
    controller: ScrollController(),
    child: Stack(
      fit: StackFit.expand,
      children: [
        const SizedScrollableArea(primary: true),

        //
        Center( // alignment?
          child: SizedBox(
            width: 200.0, // cross axis length
            child: ListView(
              primary: true,
              children: [
                const SizedBox(
                  height: 200.0, // main axis length
                  child: const Card(),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
  ```

  After:

  ```dart
  CustomListView(
    crossAxisAlignment: CustomListViewItemAlignment.center, // default
    children: [
      CustomListViewItemDelegate(
        mainAxisLength: 200.0,
        crossAxisLength: 200.0,
        child: Card(),
      ),
    ],
  );
  ```

## 1.0.0 - Initial Release

### Added

* Updated docs.
* More examples.

## 0.1.1

### Fixed

* `TextX.applyOpacity` invalid style reference for null style `Text`.

## Others

* Add `TextStyleX.applyOpacity`, extension on `TextStyle` to apply opacity.
* Update docs.

## 0.1.0

### Added

#### Extensions

* on `BuildContext`:

  * `theme`, shorthand for `Theme.of(context)`.
  * `colorScheme`, shorthand for `Theme.of(context).colorScheme`.
  * `textTheme`, shorthand for `Theme.of(context).textTheme`.
  * `mediaQuery`, shorthand for `MediaQuery.of(context)`.
  * `scaffold`, shorthand for `Scaffold.of(context)`.
  * `scaffoldMessenger`, shorthand for `ScaffoldMessenger.of(context)`.

* on `Text`:

  * `applyOpacity`, create a copy of `Text` with applied opacity.

* on `ValueChanged`:
  * `debounce`, prevent callback from being called too often.

#### Widgets

* `SizedScrollableArea`, a scrollable area that can be sized. It act as extra
  scrollable area (which detect touch and mouse wheel pointer) if your
  `Scrollable` widget must have fixed size.

#### Misc

* `DialogPage`, utilities for "go_router" package to show dialog. Did'nt depend
  on "go_router" package so "fl_utils" can be used without it.

* `useUrlPathStrategy`, use path url strategy to remove hash from url path

  (<https://github.com/flutter/flutter/issues/89763>).
