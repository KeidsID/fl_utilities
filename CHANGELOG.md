# Changelog

## [3.0.0](https://github.com/KeidsID/fl_utilities/compare/fl_utilities-v2.0.1...fl_utilities-v3.0.0) (2025-02-20)


### ⚠ BREAKING CHANGES

* 

### Features

* add [CustomListViewDelegate] as item delegate default on [CustomListView] ([fe2cc5a](https://github.com/KeidsID/fl_utilities/commit/fe2cc5a8aa645384d9014e3b8ed14251392926b8))
* add more utils ([63f0b0a](https://github.com/KeidsID/fl_utilities/commit/63f0b0ac059f1733c0bebbb6d75e1aaef2bb2308))
* simple debounce extension for [TextField] ([d9eaaf5](https://github.com/KeidsID/fl_utilities/commit/d9eaaf5f1e50f51f48fddfaea6795b121031f989))
* **widgets:** add [CustomListView.crossAxisAlignment]. ([17bc4ac](https://github.com/KeidsID/fl_utilities/commit/17bc4ac592425cb947e3565b8dfda461c9b74b9f))
* **widgets:** add [CustomListViewItem] widget and [CustomListView.separated] constructor. ([94b8535](https://github.com/KeidsID/fl_utilities/commit/94b85352afe4017d8daaa835a5bf10ddab45846c))


### Bug Fixes

* [TextX.applyOpacity] invalid style reference on null [Text.style]. ([7be6d6b](https://github.com/KeidsID/fl_utilities/commit/7be6d6bdd66de9d69fbb800e7cd35f5d628c05b3))
* **ci/cd:** delete unwanted workflow step ([fc73534](https://github.com/KeidsID/fl_utilities/commit/fc73534b39e9a05eb77310e8b511f90ec3e42761))
* **ci:** fix skipped codecov step. ([fde7c31](https://github.com/KeidsID/fl_utilities/commit/fde7c3140e663e234b59707e9e7fd1e269f84908))
* **widgets:** [SizedScrollableArea] horizontal mouse wheel fixed. ([61d6a45](https://github.com/KeidsID/fl_utilities/commit/61d6a45615879ef28f38ba77a07794be74587e90))
* **workflows:** fix publish workflow. ([07a5098](https://github.com/KeidsID/fl_utilities/commit/07a5098f5269dd49163e2ea2f3970e3570e09179))


### Code Refactoring

* new project envs flu-5 ([#6](https://github.com/KeidsID/fl_utilities/issues/6)) ([fe1833a](https://github.com/KeidsID/fl_utilities/commit/fe1833af459c54791197387af3c35a97f457f0c3))

## 2.0.1

- feat: `CustomListViewDelegate`, default item delegate for the `CustomListView`
  children. Used on `CustomListView.viewDelegate`.
- _deprecated_: `CustomListView.crossAxisAlignment`, is now deprecated in favor of
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

- `CustomListView], a custom`ListView` with customizeable children.
- `CustomListViewItemDelegate`, delegate to customize `CustomListView` item.
- `CustomListViewItemAlignment`, an enum to control item cross axis alignment of
  `CustomListView`.
- `CustomListViewItem`, a widget implementation for
  `CustomListViewItemDelegate`, not to be used directly.

### Removed

- `SizedScrollableArea`

### Breaking Changes

The main reason why `SizedScrollableArea` exist because there's some cases that
we need to modify the `ListView` item cross axis length, but we still wanted the
scroll area fill the whole screen.

But why replace `SizedScrollableArea` with `CustomListView`?

- The `SizedScrollableArea` widget is too verbose (Need same controller to
  control scroll).
- The `CustomListView` widget is more flexible because it just a `ListView` with
  some extra features (such as manipulate cross axis length).
- And actually `SizedScrollableArea` is not stable yet (too much bugs).

### Migrate Guide

- `SizedScrollableArea` -> `CustomListView`

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

- Updated docs.
- More examples.

## 0.1.1

### Fixed

- `TextX.applyOpacity` invalid style reference for null style `Text`.

## Others

- Add `TextStyleX.applyOpacity`, extension on `TextStyle` to apply opacity.
- Update docs.

## 0.1.0

### Added

#### Extensions

- on `BuildContext`:

  - `theme`, shorthand for `Theme.of(context)`.
  - `colorScheme`, shorthand for `Theme.of(context).colorScheme`.
  - `textTheme`, shorthand for `Theme.of(context).textTheme`.
  - `mediaQuery`, shorthand for `MediaQuery.of(context)`.
  - `scaffold`, shorthand for `Scaffold.of(context)`.
  - `scaffoldMessenger`, shorthand for `ScaffoldMessenger.of(context)`.

- on `Text`:

  - `applyOpacity`, create a copy of `Text` with applied opacity.

- on `ValueChanged`:
  - `debounce`, prevent callback from being called too often.

#### Widgets

- `SizedScrollableArea`, a scrollable area that can be sized. It act as extra
  scrollable area (which detect touch and mouse wheel pointer) if your
  `Scrollable` widget must have fixed size.

#### Misc

- `DialogPage`, utilities for "go_router" package to show dialog. Did'nt depend
  on "go_router" package so "fl_utils" can be used without it.

- `useUrlPathStrategy`, use path url strategy to remove hash from url path
  (<https://github.com/flutter/flutter/issues/89763>).
