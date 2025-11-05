import 'dart:math';
import 'package:flutter/material.dart';

/// Waves Painter - Animated wave patterns
class WavesPainter extends CustomPainter {
  final Animation<double> animation;
  final Random random;

  WavesPainter({
    required this.animation,
    required this.random,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Draw multiple wave layers
    for (int layer = 0; layer < 8; layer++) {
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = HSVColor.fromAHSV(
          0.6 - layer * 0.05,
          (layer * 45 + animation.value * 360) % 360,
          0.8,
          1.0,
        ).toColor();

      final path = Path();
      final points = 200;
      final radius = 100.0 + layer * 60;
      final waveCount = 3 + layer;
      final amplitude = 30.0 + layer * 5;

      for (int i = 0; i <= points; i++) {
        final angle = (i / points) * 2 * pi;
        final wave = sin(angle * waveCount + animation.value * 2 * pi) *
            amplitude;
        final r = radius + wave;

        final x = centerX + cos(angle) * r;
        final y = centerY + sin(angle) * r;

        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      path.close();
      canvas.drawPath(path, paint);

      // Add glow effect
      final glowPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..color = paint.color.withValues(alpha: 0.2)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

      canvas.drawPath(path, glowPaint);
    }

    // Draw central pulsing circle
    final centralPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = HSVColor.fromAHSV(
        0.8,
        animation.value * 360,
        0.9,
        1.0,
      ).toColor();

    final pulseRadius = 20 + sin(animation.value * 4 * pi) * 10;

    canvas.drawCircle(
      Offset(centerX, centerY),
      pulseRadius,
      centralPaint,
    );

    // Glow for central circle
    final centralGlow = Paint()
      ..style = PaintingStyle.fill
      ..color = centralPaint.color.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);

    canvas.drawCircle(
      Offset(centerX, centerY),
      pulseRadius * 2,
      centralGlow,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

