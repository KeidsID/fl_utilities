import 'package:flutter/material.dart';

extension TextStyleX on Text {
  /// Creates a copy of this [Text] replacing the [TextStyle.color] opacity.
  ///
  /// Better performance than wrapping [Text] with [Opacity].
  Text applyOpacity([double opacity = 1.0]) {
    final text = data;
    final appliedStyle =
        style?.apply(color: style?.color?.withOpacity(opacity));

    if (text == null) {
      return Text.rich(
        textSpan!,
        key: key,
        style: appliedStyle,
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
    }

    return Text(
      text,
      key: key,
      style: appliedStyle,
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
  }
}
