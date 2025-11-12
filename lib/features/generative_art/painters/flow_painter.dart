import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// Flow Field Painter - Organic flowing particles with curl noise
class FlowPainter extends CustomPainter {
  final Animation<double> animation;
  final Random random;
  final double flowSpeed;
  final double particleDensity;
  final double trailLength;
  final double hue;

  late List<FlowParticle> _particles;
  static const int _particleCount = 800;

  FlowPainter({
    required this.animation,
    required this.random,
    this.flowSpeed = 1.0,
    this.particleDensity = 1.0,
    this.trailLength = 1.0,
    this.hue = 0.0,
  }) {
    _particles = [];
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == 0 || size.height == 0) return;

    // Initialize particles if needed
    if (_particles.isEmpty) {
      final count = (_particleCount * particleDensity).toInt();
      for (int i = 0; i < count; i++) {
        _particles.add(FlowParticle(
          x: random.nextDouble() * size.width,
          y: random.nextDouble() * size.height,
          hue: (hue + random.nextDouble() * 60 - 30) % 360,
        ));
      }
    }

    final time = animation.value * 2 * pi;

    // Draw flowing particles with trails
    for (var particle in _particles) {
      // Calculate flow field direction using curl noise
      final angle = _getCurlNoise(
        particle.x / size.width,
        particle.y / size.height,
        time * flowSpeed * 0.3,
      );

      // Update particle position
      final speed = 2.0 * flowSpeed;
      final dx = cos(angle) * speed;
      final dy = sin(angle) * speed;

      particle.prevX = particle.x;
      particle.prevY = particle.y;
      particle.x += dx;
      particle.y += dy;

      // Wrap around edges
      if (particle.x < 0) particle.x = size.width;
      if (particle.x > size.width) particle.x = 0;
      if (particle.y < 0) particle.y = size.height;
      if (particle.y > size.height) particle.y = 0;

      // Draw trail
      final trailPaint = Paint()
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round
        ..shader = ui.Gradient.linear(
          Offset(particle.prevX, particle.prevY),
          Offset(particle.x, particle.y),
          [
            HSVColor.fromAHSV(0.0, particle.hue, 0.8, 1.0).toColor(),
            HSVColor.fromAHSV(0.6 * trailLength, particle.hue, 0.8, 1.0)
                .toColor(),
          ],
        );

      canvas.drawLine(
        Offset(particle.prevX, particle.prevY),
        Offset(particle.x, particle.y),
        trailPaint,
      );

      // Draw particle glow
      final glowPaint = Paint()
        ..color = HSVColor.fromAHSV(0.3, particle.hue, 0.8, 1.0).toColor()
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

      canvas.drawCircle(
        Offset(particle.x, particle.y),
        2,
        glowPaint,
      );
    }

    // Draw flow field visualization (subtle grid)
    _drawFlowFieldGrid(canvas, size, time);
  }

  /// Draw subtle flow field grid for visual interest
  void _drawFlowFieldGrid(Canvas canvas, Size size, double time) {
    final gridSize = 40.0;
    final cols = (size.width / gridSize).ceil();
    final rows = (size.height / gridSize).ceil();

    final linePaint = Paint()
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        final x = i * gridSize + gridSize / 2;
        final y = j * gridSize + gridSize / 2;

        final angle = _getCurlNoise(
          x / size.width,
          y / size.height,
          time * flowSpeed * 0.3,
        );

        final length = 15.0;
        final x1 = x - cos(angle) * length / 2;
        final y1 = y - sin(angle) * length / 2;
        final x2 = x + cos(angle) * length / 2;
        final y2 = y + sin(angle) * length / 2;

        // Color based on angle
        final colorHue = (hue + (angle / (2 * pi)) * 60) % 360;
        linePaint.color =
            HSVColor.fromAHSV(0.15, colorHue, 0.6, 1.0).toColor();

        canvas.drawLine(
          Offset(x1, y1),
          Offset(x2, y2),
          linePaint,
        );
      }
    }
  }

  /// Generate curl noise for organic flow patterns
  double _getCurlNoise(double x, double y, double t) {
    // Multi-octave curl noise for more organic patterns
    double angle = 0;

    // First octave
    angle += _simplex3D(x * 2, y * 2, t) * pi;

    // Second octave
    angle += _simplex3D(x * 4 + 100, y * 4 + 100, t * 0.5) * pi * 0.5;

    // Third octave
    angle += _simplex3D(x * 8 + 200, y * 8 + 200, t * 0.25) * pi * 0.25;

    return angle;
  }

  /// Simplified 3D simplex noise approximation
  double _simplex3D(double x, double y, double z) {
    // Simple pseudo-noise using sine waves
    final n1 = sin(x * 1.5 + z) * cos(y * 1.5);
    final n2 = sin(y * 2.0 + z * 0.5) * cos(x * 2.0);
    final n3 = sin((x + y) * 1.0 + z * 0.3);

    return (n1 + n2 + n3) / 3.0;
  }

  @override
  bool shouldRepaint(FlowPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value ||
        flowSpeed != oldDelegate.flowSpeed ||
        particleDensity != oldDelegate.particleDensity ||
        trailLength != oldDelegate.trailLength ||
        hue != oldDelegate.hue;
  }
}

/// Flow particle with trail
class FlowParticle {
  double x;
  double y;
  double prevX;
  double prevY;
  double hue;

  FlowParticle({
    required this.x,
    required this.y,
    required this.hue,
  })  : prevX = x,
        prevY = y;
}

