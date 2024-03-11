# unreleased

### Added

- [CustomListView], a custom [ListView] with customizeable children.
- [CustomListViewItemDelegate], delegate to customize [CustomListView] item.
- [CustomListViewItemAlignment], an enum to control item cross axis alignment of
  [CustomListView].
- [CustomListViewItem], a widget implementation for
  [CustomListViewItemDelegate], not to be used directly.

### Removed

- [SizedScrollableArea]

## Breaking Changes

The main reason why [SizedScrollableArea] exist because there's some cases that
we need to modify the [ListView] item cross axis length, but we still wanted the
scroll area fill the whole screen.

But why replace [SizedScrollableArea] with [CustomListView]?

- The [SizedScrollableArea] widget is too verbose (Need same controller to
  control scroll).
- The [CustomListView] widget is more flexible because it just a [ListView] with
  some extra features (such as manipulate cross axis length).
- And actually [SizedScrollableArea] is not stable yet (too much bugs).

### Migrate Guide

- [SizedScrollableArea] -> [CustomListView]

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
    children: [
      CustomListViewItemDelegate(
        mainAxisLength: 200.0,
        crossAxisLength: 200.0,
        crossAxisAlignment: CustomListViewItemAlignment.center, // default
        child: Card(),
      ),
    ],
  );
  ```

# 1.0.0 - Initial Release

## Added

- Updated docs.
- More examples.

# 0.1.1

## Fixed

- [TextX.applyOpacity] invalid style reference for null style [Text].

## Others

- Add [TextStyleX.applyOpacity], extension on [TextStyle] to apply opacity.
- Update docs.

# 0.1.0

## Added

### Extensions

- on [BuildContext]:

  - `theme`, shorthand for `Theme.of(context)`.
  - `colorScheme`, shorthand for `Theme.of(context).colorScheme`.
  - `textTheme`, shorthand for `Theme.of(context).textTheme`.
  - `mediaQuery`, shorthand for `MediaQuery.of(context)`.
  - `scaffold`, shorthand for `Scaffold.of(context)`.
  - `scaffoldMessenger`, shorthand for `ScaffoldMessenger.of(context)`.

- on [Text]:

  - `applyOpacity`, create a copy of [Text] with applied opacity.

- on [ValueChanged]:
  - `debounce`, prevent callback from being called too often.

### Widgets

- `SizedScrollableArea`, a scrollable area that can be sized. It act as extra
  scrollable area (which detect touch and mouse wheel pointer) if your
  [Scrollable] widget must have fixed size.

### Others

- `DialogPage`, utilities for "go_router" package to show dialog. Did'nt depend
  on "go_router" package so "fl_utils" can be used without it.

- `useUrlPathStrategy`, use path url strategy to remove hash from url path
  (https://github.com/flutter/flutter/issues/89763).
