import 'dart:math';
import 'package:flutter/material.dart';

/// Fractals Painter - Animated fractal tree patterns
class FractalsPainter extends CustomPainter {
  final Animation<double> animation;
  final Random random;

  FractalsPainter({required this.animation, required this.random})
    : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final bottomY = size.height;

    // Draw multiple fractal trees from different positions
    final positions = [
      Offset(centerX, bottomY),
      Offset(centerX - 200, bottomY),
      Offset(centerX + 200, bottomY),
      Offset(centerX - 400, bottomY),
      Offset(centerX + 400, bottomY),
    ];

    for (int i = 0; i < positions.length; i++) {
      final hue = (i * 72 + animation.value * 360) % 360;
      _drawFractalTree(
        canvas,
        positions[i],
        -pi / 2, // Start pointing up
        100 + sin(animation.value * 2 * pi + i) * 20,
        hue,
        0,
      );
    }
  }

  void _drawFractalTree(
    Canvas canvas,
    Offset start,
    double angle,
    double length,
    double hue,
    int depth,
  ) {
    if (depth > 10 || length < 2) return;

    final end = Offset(
      start.dx + cos(angle) * length,
      start.dy + sin(angle) * length,
    );

    final paint = Paint()
      ..color = HSVColor.fromAHSV(1.0 - depth * 0.08, hue, 0.8, 1.0).toColor()
      ..strokeWidth = max(1.0, 8.0 - depth)
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(start, end, paint);

    // Add glow effect for branches
    if (depth > 5) {
      final glowPaint = Paint()
        ..color = paint.color.withValues(alpha: 0.5)
        ..strokeWidth = paint.strokeWidth * 2
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

      canvas.drawLine(start, end, glowPaint);
    }

    // Recursive branches with animation
    final angleOffset = pi / 6 + sin(animation.value * 2 * pi) * 0.2;
    final lengthFactor = 0.67 + sin(animation.value * 2 * pi + depth) * 0.05;

    _drawFractalTree(
      canvas,
      end,
      angle - angleOffset,
      length * lengthFactor,
      hue,
      depth + 1,
    );

    _drawFractalTree(
      canvas,
      end,
      angle + angleOffset,
      length * lengthFactor,
      hue,
      depth + 1,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
