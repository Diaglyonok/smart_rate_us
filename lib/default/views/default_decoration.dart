import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

BoxDecoration getCardDecoration(
  BuildContext context, {
  BorderRadius? borderRadius,
}) => BoxDecoration(
  borderRadius: borderRadius ?? BorderRadius.circular(16),
  color: Theme.of(context).colorScheme.surface,
  boxShadow: [
    BoxShadow(
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
      blurRadius: 6.0,
      offset: const Offset(0.0, 2.0),
    ),
  ],
);

const double _kSelectionHandleRadius = 6;
const double _kSelectionHandleOverlap = 1.5;

class _CupertinoTextSelectionHandlePainter extends CustomPainter {
  const _CupertinoTextSelectionHandlePainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const double halfStrokeWidth = 1.0;
    final Paint paint = Paint()..color = color;
    final Rect circle = Rect.fromCircle(
      center: const Offset(_kSelectionHandleRadius, _kSelectionHandleRadius),
      radius: _kSelectionHandleRadius,
    );
    final Rect line = Rect.fromPoints(
      const Offset(
        _kSelectionHandleRadius - halfStrokeWidth,
        2 * _kSelectionHandleRadius - _kSelectionHandleOverlap,
      ),
      Offset(_kSelectionHandleRadius + halfStrokeWidth, size.height),
    );
    final Path path = Path()
      ..addOval(circle)
      // Draw line so it slightly overlaps the circle.
      ..addRect(line);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CupertinoTextSelectionHandlePainter oldPainter) =>
      color != oldPainter.color;
}

class ColoredCupertinoControlls extends CupertinoTextSelectionControls {
  final Color color;

  ColoredCupertinoControlls(this.color);

  @override
  Widget buildHandle(
    BuildContext context,
    TextSelectionHandleType type,
    double textLineHeight, [
    VoidCallback? onTap,
  ]) {
    // iOS selection handles do not respond to taps.
    final Size desiredSize;
    final Widget handle;

    final Widget customPaint = CustomPaint(
      painter: _CupertinoTextSelectionHandlePainter(color),
    );

    // [buildHandle]'s widget is positioned at the selection cursor's bottom
    // baseline. We transform the handle such that the SizedBox is superimposed
    // on top of the text selection endpoints.
    switch (type) {
      case TextSelectionHandleType.left:
        desiredSize = getHandleSize(textLineHeight);
        handle = SizedBox.fromSize(size: desiredSize, child: customPaint);
        return handle;
      case TextSelectionHandleType.right:
        desiredSize = getHandleSize(textLineHeight);
        handle = SizedBox.fromSize(size: desiredSize, child: customPaint);
        return Transform(
          transform: Matrix4.identity()
            ..setTranslationRaw(
              desiredSize.width / 2,
              desiredSize.height / 2,
              0,
            )
            ..rotateZ(math.pi)
            ..setTranslationRaw(
              -desiredSize.width / 2,
              -desiredSize.height / 2,
              0,
            ),
          child: handle,
        );
      // iOS should draw an invisible box so the handle can still receive gestures
      // on collapsed selections.
      case TextSelectionHandleType.collapsed:
        return SizedBox.fromSize(size: getHandleSize(textLineHeight));
    }
  }
}

TextSelectionControls getControls(BuildContext context) =>
    !kIsWeb && Platform.isIOS
    ? ColoredCupertinoControlls(Theme.of(context).colorScheme.secondary)
    : MaterialTextSelectionControls();

InputDecoration defaultDecoration(BuildContext context) => InputDecoration(
  disabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Theme.of(context).colorScheme.onSurface,
      width: 0.4,
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Theme.of(context).colorScheme.secondary,
      width: 1,
    ),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Theme.of(context).colorScheme.onSurface,
      width: 0.4,
    ),
  ),
  labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
    color: Theme.of(context).colorScheme.onSurface,
  ),
  hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
  ),
  counterStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
    fontSize: 12,
    color: Theme.of(context).colorScheme.onSurface,
  ),
  errorStyle: Theme.of(
    context,
  ).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.error),
  errorMaxLines: 3,
  focusedErrorBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Theme.of(context).colorScheme.error,
      width: 1,
    ),
  ),
  errorBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Theme.of(context).colorScheme.error,
      width: 1,
    ),
  ),
);
