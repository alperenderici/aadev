import 'dart:math';
import 'package:flutter/material.dart';

/// Galaxy Painter - A rotating spiral galaxy with a glowing core, drifting
/// nebula clouds, a twinkling starfield, and streaking shooting stars.
class GalaxyPainter extends CustomPainter {
  final Animation<double> animation;
  final Random random;
  final double rotationSpeed;
  final double starDensity;
  final double coreGlow;
  final double hue;

  GalaxyPainter({
    required this.animation,
    required this.random,
    this.rotationSpeed = 1.0,
    this.starDensity = 1.0,
    this.coreGlow = 1.0,
    this.hue = 0.0,
  }) : super(repaint: animation);

  /// Deterministic pseudo-random value in [0, 1) for a given seed, so the
  /// starfield stays stable across frames even though a new painter
  /// instance is created every tick.
  double _hash(int seed) {
    final x = sin(seed * 12.9898) * 43758.5453;
    return x - x.floorToDouble();
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.black,
    );

    final center = Offset(size.width / 2, size.height / 2);
    final baseHue = hue > 0 ? hue : 260.0;
    final t = animation.value;

    _drawBackgroundStars(canvas, size, t);
    _drawNebulaClouds(canvas, center, baseHue, t);
    _drawSpiralArms(canvas, center, size, baseHue, t);
    _drawCore(canvas, center, baseHue, t);
    _drawShootingStars(canvas, size, t);
  }

  void _drawBackgroundStars(Canvas canvas, Size size, double t) {
    final count = (220 * starDensity).toInt().clamp(60, 500);

    for (int i = 0; i < count; i++) {
      final x = _hash(i * 3 + 1) * size.width;
      final y = _hash(i * 3 + 2) * size.height;
      final twinkleSpeed = 0.5 + _hash(i * 3 + 3) * 2.5;
      final phase = _hash(i * 7 + 5) * 2 * pi;
      final twinkle = (sin(t * 2 * pi * twinkleSpeed + phase) + 1) / 2;
      final starSize = 0.5 + _hash(i * 5 + 9) * 1.5;

      final paint = Paint()
        ..color = Colors.white.withValues(alpha: 0.2 + twinkle * 0.8);

      canvas.drawCircle(Offset(x, y), starSize, paint);
    }
  }

  void _drawNebulaClouds(
    Canvas canvas,
    Offset center,
    double baseHue,
    double t,
  ) {
    const cloudCount = 5;

    for (int i = 0; i < cloudCount; i++) {
      final angle =
          (i / cloudCount) * 2 * pi + t * rotationSpeed * 2 * pi * 0.2;
      final dist = 120 + _hash(i * 11 + 3) * 220;
      final x = center.dx + cos(angle) * dist;
      final y = center.dy + sin(angle) * dist * 0.6;

      final cloudHue = (baseHue + i * 35 + t * 20) % 360;
      final pulse = 0.7 + sin(t * 2 * pi + i) * 0.3;
      final radius = (90 + _hash(i * 13 + 7) * 60) * coreGlow * pulse;

      final paint = Paint()
        ..color = HSVColor.fromAHSV(0.12, cloudHue, 0.7, 1.0).toColor()
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 60);

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  void _drawSpiralArms(
    Canvas canvas,
    Offset center,
    Size size,
    double baseHue,
    double t,
  ) {
    const numArms = 3;
    final starsPerArm = (90 * starDensity).toInt().clamp(30, 220);
    final maxRadius = min(size.width, size.height) * 0.55;
    final rotation = t * rotationSpeed * 2 * pi * 0.5;

    for (int arm = 0; arm < numArms; arm++) {
      final armOffset = (arm / numArms) * 2 * pi;

      for (int i = 0; i < starsPerArm; i++) {
        final progress = i / starsPerArm;
        final angle = armOffset + rotation + progress * 3.2 * pi;
        final radius = progress * maxRadius;
        final wobble = sin(progress * 20 + t * 2 * pi) * 6 * progress;

        final x = center.dx + cos(angle) * radius;
        final y = center.dy + sin(angle) * radius * 0.55 + wobble;

        final starHue = (baseHue + progress * 60 + arm * 15) % 360;
        final brightness = (1 - progress * 0.6).clamp(0.2, 1.0);
        final twinkle = (sin(t * 2 * pi * 3 + i + arm * 10) + 1) / 2;

        final glowPaint = Paint()
          ..color = HSVColor.fromAHSV(
            0.25 * brightness,
            starHue,
            0.6,
            1.0,
          ).toColor()
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
        canvas.drawCircle(Offset(x, y), 3 + twinkle * 2, glowPaint);

        final starPaint = Paint()
          ..color = HSVColor.fromAHSV(brightness, starHue, 0.5, 1.0).toColor();
        canvas.drawCircle(Offset(x, y), 0.8 + twinkle * 1.2, starPaint);
      }
    }
  }

  void _drawCore(Canvas canvas, Offset center, double baseHue, double t) {
    final pulse = 0.85 + sin(t * 2 * pi * 1.5) * 0.15;
    final coreRadius = 26 * coreGlow * pulse;

    final outerGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          HSVColor.fromAHSV(0.5, baseHue, 0.4, 1.0).toColor(),
          HSVColor.fromAHSV(0.0, baseHue, 0.4, 1.0).toColor(),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: coreRadius * 4));
    canvas.drawCircle(center, coreRadius * 4, outerGlow);

    final corePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white,
          HSVColor.fromAHSV(1.0, baseHue, 0.3, 1.0).toColor(),
          HSVColor.fromAHSV(0.0, baseHue, 0.3, 1.0).toColor(),
        ],
        stops: const [0.0, 0.4, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: coreRadius));
    canvas.drawCircle(center, coreRadius, corePaint);
  }

  void _drawShootingStars(Canvas canvas, Size size, double t) {
    const numShootingStars = 3;
    const burstWindow = 0.25;

    for (int i = 0; i < numShootingStars; i++) {
      final cycleLength = 1.0 / numShootingStars;
      final localT = (t * rotationSpeed + i * cycleLength) % 1.0;

      if (localT > burstWindow) continue;

      final progress = localT / burstWindow;
      final startX = _hash(i * 17 + 1) * size.width * 0.6;
      final startY = _hash(i * 19 + 2) * size.height * 0.4;
      final angle = pi / 4 + _hash(i * 23 + 3) * 0.4;
      const length = 140.0;

      final headX = startX + cos(angle) * progress * size.width * 0.7;
      final headY = startY + sin(angle) * progress * size.height * 0.5;
      final tailX = headX - cos(angle) * length;
      final tailY = headY - sin(angle) * length;

      final fade = 1 - progress;
      final trailPaint = Paint()
        ..shader =
            LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.9 * fade),
                Colors.white.withValues(alpha: 0.0),
              ],
            ).createShader(
              Rect.fromPoints(Offset(headX, headY), Offset(tailX, tailY)),
            )
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(Offset(headX, headY), Offset(tailX, tailY), trailPaint);

      final headPaint = Paint()..color = Colors.white.withValues(alpha: fade);
      canvas.drawCircle(Offset(headX, headY), 2, headPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
