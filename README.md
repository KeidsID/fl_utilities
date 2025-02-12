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

# fl_utilities

![Dart version](https://img.shields.io/badge/SDK-^3.0.0-red?style=flat&logo=dart&logoColor=2cb8f7&labelColor=333333&color=01579b)
![Flutter](https://img.shields.io/badge/SDK-^3.10.0-red?style=flat&logo=flutter&logoColor=2cb8f7&labelColor=333333&color=01579b)
![pub points](https://img.shields.io/pub/points/fl_utilities?labelColor=333333&color=01579b)

[![Test](https://github.com/KeidsID/fl_utilities/actions/workflows/test.yml/badge.svg)](https://github.com/KeidsID/fl_utilities/actions/workflows/test.yml)
[![codecov](https://codecov.io/gh/KeidsID/fl_utilities/graph/badge.svg?token=PNFMB749KY)](https://codecov.io/gh/KeidsID/fl_utilities)

Simple flutter utilities such as shorthands extension on [BuildContext],
`debounce` extension on [ValueChanged], and more.

This package depend on SDKs so it can be used in any Flutter project.

[api-ref]:
  https://pub.dev/documentation/fl_utilities/latest/fl_utilities/fl_utilities-library.html

- [API Reference][api-ref]

## Getting started

Add `fl_utilities` to your dependencies.

```
flutter add fl_utilities
```

and that's it! You're good to go.

> Please note that there's no support for Flutter SDK below 3.10

## Usage

[BuildContext] shorthands extension:

```dart
import 'package:flutter/material.dart';
import 'package:fl_utilities/fl_utilities.dart';

final myWidget = Builder(builder: (context) {
  context.theme; // instead of `Theme.of(context)`
  context.mediaQuery; // instead of `MediaQuery.of(context)`

  return const Placeholder();
});
```

debounce extension on [ValueChanged]:

```dart
import 'package:flutter/material.dart';
import 'package:fl_utilities/fl_utilities.dart';

final myWidget = TextField(
  onChanged: (text) {
    debugPrint('Called after half a second of not typing');
  }.debounce(),
);
```

Visit [API Reference][api-ref] for more utilities.
