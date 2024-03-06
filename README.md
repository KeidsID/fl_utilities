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

# fl_utils

![Dart version](https://img.shields.io/badge/SDK-^3.0.0-red?style=flat&logo=dart&logoColor=2cb8f7&labelColor=333333&color=01579b)
![Flutter](https://img.shields.io/badge/SDK-^3.10.0-red?style=flat&logo=flutter&logoColor=2cb8f7&labelColor=333333&color=01579b)

Simple flutter utilities such as shorthands extension on [BuildContext],
`debounce` extension on [ValueChanged],`SizedScrollableArea` widget, and more.

This package depend on SDKs so it can be used in any Flutter project.

- [API Reference](https://pub.dev/documentation/fl_utils)

## Getting started

Add `fl_utils` to your dependencies.

```
flutter add fl_utils
```

or manually add it to your `pubspec.yaml` file:

```yaml
dependencies:
  fl_utils: ^1.0.0
```

Then you can use it in your project.

## Usage

shorthands extension on [BuildContext]:

```dart
import 'package:flutter/material.dart';
import 'package:fl_utils/fl_utils.dart';

Builder(builder: (context) {
  context.theme; // instead of `Theme.of(context)`
  context.mediaQuery; // instead of `MediaQuery.of(context)`

  return const Placeholder();
});
```

debounce extension on [ValueChanged]:

```dart
import 'package:flutter/material.dart';
import 'package:fl_utils/fl_utils.dart';

TextField(
  onChanged: (text) {
    debugPrint('Called after half a second of not typing');
  }.debounce(),
);
```

Visit [API Reference](https://pub.dev/documentation/fl_utils) for more
utilities.
