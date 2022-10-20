import 'package:flutter/material.dart';

class CustomSliderThumbRect extends SliderComponentShape {
  final double thumbRadius;
  Color thumbColor;
  final double thumbHeight;
  final int min;
  final int max;

  CustomSliderThumbRect({
    this.thumbRadius,
    this.thumbHeight,
    this.min,
    this.max,
    thumbColor,
  }) {
    this.thumbColor = thumbColor ?? Colors.grey;
  }

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    double textScaleFactor,
    Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: thumbHeight, height: thumbHeight),
      Radius.circular(thumbRadius * .4),
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke;

    final shadowPaint = Paint()
      ..color = thumbColor.withOpacity(0.4)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3 * 0.57735 + 0.5)
      ..style = PaintingStyle.fill;

   

    canvas.drawRRect(rRect, shadowPaint);
    canvas.drawRRect(rRect, paint);
  }
}
