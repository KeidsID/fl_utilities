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
