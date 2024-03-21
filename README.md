<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

[library-doc]:
  https://pub.dev/documentation/fl_utilities/latest/fl_utilities/fl_utilities-library.html

# fl_utilities

![Dart version](https://img.shields.io/badge/SDK-^3.0.0-red?style=flat&logo=dart&logoColor=2cb8f7&labelColor=333333&color=01579b)
![Flutter](https://img.shields.io/badge/SDK-^3.10.0-red?style=flat&logo=flutter&logoColor=2cb8f7&labelColor=333333&color=01579b)
![pub points](https://img.shields.io/pub/points/fl_utilities?labelColor=333333&color=01579b)

[![Test](https://github.com/KeidsID/fl_utilities/actions/workflows/test.yml/badge.svg)](https://github.com/KeidsID/fl_utilities/actions/workflows/test.yml)
[![codecov](https://codecov.io/gh/KeidsID/fl_utilities/graph/badge.svg?token=PNFMB749KY)](https://codecov.io/gh/KeidsID/fl_utilities)

Simple flutter utilities such as shorthands extension on [BuildContext],
`debounce` extension on [ValueChanged], `CustomListView` widget, and more.

This package depend on SDKs so it can be used in any Flutter project.

- [API Reference][library-doc]

## Getting started

Add `fl_utilities` to your dependencies.

```
flutter add fl_utilities
```

or manually add it to your `pubspec.yaml` file:

```yaml
dependencies:
  fl_utilities: ^2.0.1
```

Then you can use it in your project.

## Usage

shorthands extension on [BuildContext]:

```dart
import 'package:flutter/material.dart';
import 'package:fl_utilities/fl_utilities.dart';

Builder(builder: (context) {
  context.theme; // instead of `Theme.of(context)`
  context.mediaQuery; // instead of `MediaQuery.of(context)`

  return const Placeholder();
});
```

debounce extension on [ValueChanged]:

```dart
import 'package:flutter/material.dart';
import 'package:fl_utilities/fl_utilities.dart';

TextField(
  onChanged: (text) {
    debugPrint('Called after half a second of not typing');
  }.debounce(),
);
```

Customize [ListView] item cross axis length using [CustomListView]:

```dart
import 'package:flutter/material.dart';
import 'package:fl_utilities/fl_utilities.dart';

CustomListView(
  // default item delegate
  viewDelegate: CustomListViewDelegate(
    mainAxisLength: 160.0,
    crossAxisLength: 240.0,
    crossAxisAlignment: CustomListViewItemAlignment.center,
  )
  children: [
    CustomListViewItemDelegate(
      // overrides default delegate
      mainAxisLength: 240.0,
      crossAxisLength: 160.0,
      child: const Card(), // actual list item
    ),
    CustomListViewItemDelegate(
      // using default delegate
      child: const Card(),
    ),
  ]
);
```

Visit [API Reference][library-doc] for more details.
