import 'dart:math';
import 'package:flutter/material.dart';

/// Spirals Painter - Animated spiral patterns
class SpiralsPainter extends CustomPainter {
  final Animation<double> animation;
  final Random random;
  final double rotationSpeed;
  final double spiralCount;
  final double radius;
  final double hue;

  SpiralsPainter({
    required this.animation,
    required this.random,
    this.rotationSpeed = 1.0,
    this.spiralCount = 1.0,
    this.radius = 1.0,
    this.hue = 0.0,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Draw multiple spirals
    final numSpirals = (5 * spiralCount).toInt().clamp(1, 10);
    for (int spiralIndex = 0; spiralIndex < numSpirals; spiralIndex++) {
      final spiralHue = hue > 0
          ? (hue + spiralIndex * (360 / numSpirals)) % 360
          : (spiralIndex * 72 + animation.value * rotationSpeed * 360) % 360;
      final rotationOffset = spiralIndex * (2 * pi / numSpirals);

      _drawSpiral(
        canvas,
        Offset(centerX, centerY),
        spiralHue,
        rotationOffset,
        spiralIndex,
      );
    }

    // Draw central rotating mandala
    _drawMandala(canvas, Offset(centerX, centerY));
  }

  void _drawSpiral(
    Canvas canvas,
    Offset center,
    double spiralHue,
    double rotationOffset,
    int index,
  ) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final points = 500;
    final maxRadius = 400.0 * radius;

    for (int i = 0; i < points; i++) {
      final t = i / points;
      final angle =
          t * 6 * pi +
          animation.value * rotationSpeed * 2 * pi +
          rotationOffset;
      final radius = t * maxRadius;

      final x = center.dx + cos(angle) * radius;
      final y = center.dy + sin(angle) * radius;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      // Draw dots along the spiral
      if (i % 10 == 0) {
        final dotPaint = Paint()
          ..color = HSVColor.fromAHSV(
            0.8,
            (spiralHue + t * 60) % 360,
            0.8,
            1.0,
          ).toColor()
          ..style = PaintingStyle.fill;

        canvas.drawCircle(
          Offset(x, y),
          3 + sin(animation.value * 4 * pi + i) * 1,
          dotPaint,
        );

        // Glow effect
        final glowPaint = Paint()
          ..color = dotPaint.color.withValues(alpha: 0.3)
          ..style = PaintingStyle.fill
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

        canvas.drawCircle(Offset(x, y), 6, glowPaint);
      }
    }

    paint.color = HSVColor.fromAHSV(0.4, spiralHue, 0.8, 1.0).toColor();
    canvas.drawPath(path, paint);
  }

  void _drawMandala(Canvas canvas, Offset center) {
    final petals = 12;

    for (int i = 0; i < petals; i++) {
      final angle = (i / petals) * 2 * pi + animation.value * 2 * pi;
      final hue = (i / petals * 360 + animation.value * 360) % 360;

      final paint = Paint()
        ..color = HSVColor.fromAHSV(0.7, hue, 0.9, 1.0).toColor()
        ..style = PaintingStyle.fill;

      final path = Path();
      final petalLength = 50 + sin(animation.value * 4 * pi + i) * 10;

      // Create petal shape
      path.moveTo(center.dx, center.dy);

      for (double t = 0; t <= 1; t += 0.1) {
        final petalAngle = angle + (t - 0.5) * pi / 6;
        final radius = sin(t * pi) * petalLength;

        final x = center.dx + cos(petalAngle) * radius;
        final y = center.dy + sin(petalAngle) * radius;

        if (t == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      path.close();
      canvas.drawPath(path, paint);

      // Glow effect
      final glowPaint = Paint()
        ..color = paint.color.withValues(alpha: 0.3)
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

      canvas.drawPath(path, glowPaint);
    }

    // Central circle
    final centralPaint = Paint()
      ..color = HSVColor.fromAHSV(
        1.0,
        animation.value * 360,
        0.9,
        1.0,
      ).toColor()
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 15, centralPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
