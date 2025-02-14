import 'package:flutter/material.dart';

/// Extension on [Text].
///
/// See also:
/// - [TextStyleX], extension on [TextStyle].
extension TextX on Text {
  /// Creates a copy of this [Text] replacing the [TextStyle.color] opacity.
  ///
  /// Better performance than wrapping [Text] with [Opacity].
  ///
  /// [opacity] should be a value between 0.0 and 1.0.
  ///
  /// ```dart
  /// Text('Hello World').applyOpacity(opacity: 0.5);
  /// ```
  ///
  /// WARNING: This method is create a new [Text] instance, so the [Text.key]
  /// will not be used. Try apply it on the [key] argument instead.
  ///
  /// See also:
  /// - [TextStyleX.applyOpacity], extension to apply opacity on [TextStyle].
  Widget applyOpacity({Key? key, double opacity = 1.0}) {
    final text = data;

    if (text == null) {
      return Builder(builder: (context) {
        return Text.rich(
          textSpan!,
          key: key,
          style: _applyOpacityFallback(context, opacity: opacity),
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
          selectionColor: selectionColor,
        );
      });
    }

    return Builder(builder: (context) {
      return Text(
        text,
        key: key,
        style: _applyOpacityFallback(context, opacity: opacity),
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaleFactor: textScaleFactor,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      );
    });
  }

  /// [applyOpacity] helper.
  TextStyle _applyOpacityFallback(
    BuildContext context, {
    double opacity = 1.0,
  }) {
    final defaultStyle = DefaultTextStyle.of(context).style;

    return style?.applyOpacity(opacity) ?? defaultStyle.applyOpacity(opacity);
  }
}

/// Extension on [TextStyle].
///
/// See also:
/// - [TextX], extension on [Text].
extension TextStyleX on TextStyle {
  /// Creates a copy of this [TextStyle] replacing the [TextStyle.color] with
  /// the specified [opacity].
  ///
  /// [opacity] should be a value between 0.0 and 1.0.
  ///
  /// ```dart
  /// TextStyle(color: Colors.red).applyOpacity(0.5);
  /// ```
  ///
  /// See also:
  /// - [TextX.applyOpacity], extension to apply opacity on [Text] widget.
  TextStyle applyOpacity([double opacity = 1.0]) {
    assert(
      opacity >= 0.0 && opacity <= 1.0,
      'opacity must be between 0.0 and 1.0',
    );

    return apply(color: color?.withOpacity(opacity));
  }
}
