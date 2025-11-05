import 'dart:math';
import 'package:flutter/material.dart';

/// Frame Painter - Refik Anadol inspired flowing waves in a frame
class FramePainter extends CustomPainter {
  final Animation<double> animation;
  final Random random;
  final double speed;
  final double flowIntensity;
  final double particleCount;
  final double hue;

  FramePainter({
    required this.animation,
    required this.random,
    this.speed = 1.0,
    this.flowIntensity = 1.0,
    this.particleCount = 1.0,
    this.hue = 0.0,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    // Black background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.black,
    );

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Frame dimensions (portrait orientation like gallery frames)
    final frameWidth = min(size.width * 0.6, 600.0);
    final frameHeight = min(size.height * 0.7, 800.0);
    final frameLeft = centerX - frameWidth / 2;
    final frameTop = centerY - frameHeight / 2;

    // Draw white frame border
    final framePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;

    final frameRect = Rect.fromLTWH(
      frameLeft,
      frameTop,
      frameWidth,
      frameHeight,
    );

    canvas.drawRect(frameRect, framePaint);

    // Add inner shadow effect to frame
    final innerFramePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRect(
      Rect.fromLTWH(
        frameLeft + 10,
        frameTop + 10,
        frameWidth - 20,
        frameHeight - 20,
      ),
      innerFramePaint,
    );

    // Clip to frame interior for generative art
    canvas.save();
    canvas.clipRect(
      Rect.fromLTWH(
        frameLeft + 20,
        frameTop + 20,
        frameWidth - 40,
        frameHeight - 40,
      ),
    );

    // Draw Refik Anadol inspired flowing waves
    _drawFlowingWaves(
      canvas,
      frameLeft + 20,
      frameTop + 20,
      frameWidth - 40,
      frameHeight - 40,
    );

    canvas.restore();
  }

  void _drawFlowingWaves(
    Canvas canvas,
    double x,
    double y,
    double width,
    double height,
  ) {
    final centerX = x + width / 2;
    final centerY = y + height / 2;

    // Create multiple layers of flowing waves
    for (int layer = 0; layer < 15; layer++) {
      final path = Path();
      final points = 200;
      final layerOffset = layer * 30.0 * flowIntensity;
      final timeOffset = animation.value * speed * 2 * pi + layer * 0.3;

      // Blue to white gradient based on layer
      final layerHue = hue > 0
          ? (hue + layer * 5) % 360
          : 200.0 + layer * 5; // Blue range
      final saturation = 0.8 - layer * 0.03;
      final value = 0.6 + layer * 0.03;
      final alpha = 0.15 - layer * 0.005;

      final paint = Paint()
        ..color = HSVColor.fromAHSV(
          max(0.05, alpha),
          layerHue % 360,
          max(0.3, saturation),
          min(1.0, value),
        ).toColor()
        ..style = PaintingStyle.fill;

      // Create organic flowing shape
      for (int i = 0; i <= points; i++) {
        final t = i / points;
        final angle = t * 2 * pi;

        // Multiple sine waves for organic movement
        final r1 = sin(angle * 3 + timeOffset) * 30;
        final r2 = sin(angle * 5 - timeOffset * 1.5) * 20;
        final r3 = cos(angle * 7 + timeOffset * 0.8) * 15;

        final radius = layerOffset + r1 + r2 + r3;

        // Add Perlin-like noise for more organic feel
        final noiseX = sin(t * 10 + timeOffset) * 10;
        final noiseY = cos(t * 8 - timeOffset) * 10;

        final px = centerX + cos(angle) * radius + noiseX;
        final py = centerY + sin(angle) * radius + noiseY;

        if (i == 0) {
          path.moveTo(px, py);
        } else {
          path.lineTo(px, py);
        }
      }

      path.close();
      canvas.drawPath(path, paint);

      // Add glow effect for some layers
      if (layer % 3 == 0) {
        final glowPaint = Paint()
          ..color = paint.color.withValues(alpha: 0.1)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

        canvas.drawPath(path, glowPaint);
      }
    }

    // Add flowing particles for extra detail
    final numParticles = (50 * particleCount).toInt().clamp(10, 200);
    for (int i = 0; i < numParticles; i++) {
      final angle =
          (i / numParticles) * 2 * pi + animation.value * speed * 2 * pi;
      final radius =
          100 + sin(animation.value * 4 * pi + i) * 80 * flowIntensity;

      final px = centerX + cos(angle) * radius;
      final py = centerY + sin(angle) * radius;

      final particleHue = hue > 0
          ? (hue + sin(animation.value * 2 * pi + i) * 30) % 360
          : 200 + sin(animation.value * 2 * pi + i) * 30;
      final particlePaint = Paint()
        ..color = HSVColor.fromAHSV(0.6, particleHue, 0.7, 1.0).toColor()
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(px, py),
        2 + sin(animation.value * 6 * pi + i) * 1,
        particlePaint,
      );

      // Particle glow
      final glowPaint = Paint()
        ..color = particlePaint.color.withValues(alpha: 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

      canvas.drawCircle(Offset(px, py), 4, glowPaint);
    }

    // Add flowing lines connecting particles
    for (int i = 0; i < 30; i++) {
      final t = i / 30;
      final startAngle = t * 2 * pi + animation.value * 2 * pi;
      final endAngle = startAngle + pi / 6;

      final startRadius = 80 + sin(animation.value * 3 * pi + i) * 40;
      final endRadius = 120 + cos(animation.value * 3 * pi + i) * 40;

      final startX = centerX + cos(startAngle) * startRadius;
      final startY = centerY + sin(startAngle) * startRadius;
      final endX = centerX + cos(endAngle) * endRadius;
      final endY = centerY + sin(endAngle) * endRadius;

      final linePaint = Paint()
        ..color = HSVColor.fromAHSV(0.2, 210 + t * 20, 0.6, 0.9).toColor()
        ..strokeWidth = 1
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
