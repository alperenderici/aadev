import 'dart:math';
import 'package:flutter/material.dart';

/// Fractals Painter - Animated fractal tree patterns
class FractalsPainter extends CustomPainter {
  final Animation<double> animation;
  final Random random;
  final double depth;
  final double rotationSpeed;
  final double scale;
  final double hue;

  FractalsPainter({
    required this.animation,
    required this.random,
    this.depth = 1.0,
    this.rotationSpeed = 1.0,
    this.scale = 1.0,
    this.hue = 0.0,
  }) : super(repaint: animation);

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
      final treeHue = hue > 0
          ? (hue + i * 72) % 360
          : (i * 72 + animation.value * rotationSpeed * 360) % 360;
      _drawFractalTree(
        canvas,
        positions[i],
        -pi / 2, // Start pointing up
        (100 + sin(animation.value * 2 * pi + i) * 20) * scale,
        treeHue,
        0,
      );
    }
  }

  void _drawFractalTree(
    Canvas canvas,
    Offset start,
    double angle,
    double length,
    double treeHue,
    int currentDepth,
  ) {
    final maxDepth = (10 * depth).toInt();
    if (currentDepth > maxDepth || length < 2) return;

    final end = Offset(
      start.dx + cos(angle) * length,
      start.dy + sin(angle) * length,
    );

    final paint = Paint()
      ..color = HSVColor.fromAHSV(
        1.0 - currentDepth * 0.08,
        treeHue,
        0.8,
        1.0,
      ).toColor()
      ..strokeWidth = max(1.0, 8.0 - currentDepth)
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(start, end, paint);

    // Add glow effect for branches
    if (currentDepth > 5) {
      final glowPaint = Paint()
        ..color = paint.color.withValues(alpha: 0.5)
        ..strokeWidth = paint.strokeWidth * 2
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

      canvas.drawLine(start, end, glowPaint);
    }

    // Recursive branches with animation
    final angleOffset =
        pi / 6 + sin(animation.value * rotationSpeed * 2 * pi) * 0.2;
    final lengthFactor =
        0.67 + sin(animation.value * 2 * pi + currentDepth) * 0.05;

    _drawFractalTree(
      canvas,
      end,
      angle - angleOffset,
      length * lengthFactor,
      treeHue,
      currentDepth + 1,
    );

    _drawFractalTree(
      canvas,
      end,
      angle + angleOffset,
      length * lengthFactor,
      treeHue,
      currentDepth + 1,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
