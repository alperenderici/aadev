import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// Enhanced Flow Field Painter - Organic flowing particles with advanced curl noise
class FlowPainter extends CustomPainter {
  final Animation<double> animation;
  final Random random;
  final double flowSpeed;
  final double particleDensity;
  final double trailLength;
  final double hue;

  // Static particle storage to maintain state between repaints
  static List<FlowParticle>? _cachedParticles;
  static Size? _cachedSize;
  static double _cachedDensity = 1.0;
  static const int _baseParticleCount = 800;

  FlowPainter({
    required this.animation,
    required this.random,
    this.flowSpeed = 1.0,
    this.particleDensity = 1.0,
    this.trailLength = 1.0,
    this.hue = 0.0,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == 0 || size.height == 0) return;

    final time =
        animation.value *
        10; // Increased time multiplier for smoother animation

    // Initialize or update particles
    if (_cachedParticles == null ||
        _cachedSize != size ||
        _cachedDensity != particleDensity) {
      _initializeParticles(size);
      _cachedSize = size;
      _cachedDensity = particleDensity;
    }

    // Draw dynamic background gradient
    _drawDynamicBackground(canvas, size, time);

    // Draw energy waves (new feature)
    _drawEnergyWaves(canvas, size, time);

    // Update and draw particles with enhanced trails
    _updateAndDrawParticles(canvas, size, time);

    // Draw particle connections (new feature)
    _drawParticleConnections(canvas, size);

    // Draw enhanced flow field visualization
    _drawFlowFieldGrid(canvas, size, time);
  }

  /// Initialize particles with proper state management
  void _initializeParticles(Size size) {
    final count = (_baseParticleCount * particleDensity).toInt();
    _cachedParticles = List.generate(count, (i) {
      return FlowParticle(
        x: random.nextDouble() * size.width,
        y: random.nextDouble() * size.height,
        hue: (hue + random.nextDouble() * 60 - 30) % 360,
        speed: 0.8 + random.nextDouble() * 0.4, // Variable speed
        size: 1.0 + random.nextDouble() * 2.0, // Variable size
      );
    });
  }

  /// Draw dynamic background with subtle gradient animation
  void _drawDynamicBackground(Canvas canvas, Size size, double time) {
    final bgPaint = Paint()
      ..shader = ui.Gradient.radial(
        Offset(size.width / 2, size.height / 2),
        size.width * 0.8,
        [
          HSVColor.fromAHSV(0.03, (hue + time * 2) % 360, 0.6, 0.3).toColor(),
          HSVColor.fromAHSV(
            0.01,
            (hue + time * 2 + 180) % 360,
            0.4,
            0.2,
          ).toColor(),
          Colors.transparent,
        ],
        [0.0, 0.5, 1.0],
      );
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);
  }

  /// Draw energy waves that pulse through the field
  void _drawEnergyWaves(Canvas canvas, Size size, double time) {
    final wavePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (int i = 0; i < 3; i++) {
      final phase = (time * 0.5 + i * 2.0) % 10.0;
      final radius = (phase / 10.0) * size.width * 1.5;
      final opacity = (1.0 - phase / 10.0) * 0.2;

      wavePaint.color = HSVColor.fromAHSV(
        opacity,
        (hue + i * 120) % 360,
        0.7,
        1.0,
      ).toColor();

      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        radius,
        wavePaint,
      );
    }
  }

  /// Update particle positions and draw with enhanced trails
  void _updateAndDrawParticles(Canvas canvas, Size size, double time) {
    if (_cachedParticles == null) return;

    for (var particle in _cachedParticles!) {
      // Store trail history
      particle.addToTrail();

      // Calculate flow field direction using enhanced curl noise
      final angle = _getEnhancedCurlNoise(
        particle.x / size.width,
        particle.y / size.height,
        time * flowSpeed * 0.05,
      );

      // Update particle position with variable speed
      final speed = 1.5 * flowSpeed * particle.speed;
      final dx = cos(angle) * speed;
      final dy = sin(angle) * speed;

      particle.x += dx;
      particle.y += dy;

      // Wrap around edges with smooth transition
      if (particle.x < -10) particle.x = size.width + 10;
      if (particle.x > size.width + 10) particle.x = -10;
      if (particle.y < -10) particle.y = size.height + 10;
      if (particle.y > size.height + 10) particle.y = -10;

      // Update particle hue based on velocity
      final velocity = sqrt(dx * dx + dy * dy);
      particle.hue = (hue + velocity * 10 + time * 5) % 360;

      // Draw enhanced trail with multiple segments
      _drawEnhancedTrail(canvas, particle);

      // Draw particle with glow and size variation
      _drawParticle(canvas, particle, time);
    }
  }

  /// Draw enhanced trail with gradient and multiple segments
  void _drawEnhancedTrail(Canvas canvas, FlowParticle particle) {
    if (particle.trail.length < 2) return;

    final maxTrailLength = (10 * trailLength).toInt().clamp(2, 20);
    final trailSegments = particle.trail.length > maxTrailLength
        ? particle.trail.sublist(particle.trail.length - maxTrailLength)
        : particle.trail;

    for (int i = 0; i < trailSegments.length - 1; i++) {
      final progress = i / trailSegments.length;
      final opacity = progress * 0.4 * trailLength;
      final strokeWidth = (1.0 + progress * 2.0) * trailLength;

      final trailPaint = Paint()
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..shader = ui.Gradient.linear(trailSegments[i], trailSegments[i + 1], [
          HSVColor.fromAHSV(opacity * 0.5, particle.hue, 0.8, 1.0).toColor(),
          HSVColor.fromAHSV(opacity, particle.hue, 0.9, 1.0).toColor(),
        ]);

      canvas.drawLine(trailSegments[i], trailSegments[i + 1], trailPaint);
    }
  }

  /// Draw particle with glow and pulsing effect
  void _drawParticle(Canvas canvas, FlowParticle particle, double time) {
    final pulse = (sin(time * 2 + particle.x * 0.01) * 0.5 + 0.5);
    final particleSize = particle.size * (1.0 + pulse * 0.3);

    // Outer glow
    final outerGlowPaint = Paint()
      ..color = HSVColor.fromAHSV(0.2, particle.hue, 0.7, 1.0).toColor()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    canvas.drawCircle(
      Offset(particle.x, particle.y),
      particleSize * 3,
      outerGlowPaint,
    );

    // Inner glow
    final innerGlowPaint = Paint()
      ..color = HSVColor.fromAHSV(0.6, particle.hue, 0.8, 1.0).toColor()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    canvas.drawCircle(
      Offset(particle.x, particle.y),
      particleSize * 1.5,
      innerGlowPaint,
    );

    // Core particle
    final corePaint = Paint()
      ..color = HSVColor.fromAHSV(0.9, particle.hue, 0.9, 1.0).toColor();

    canvas.drawCircle(Offset(particle.x, particle.y), particleSize, corePaint);
  }

  /// Draw connections between nearby particles
  void _drawParticleConnections(Canvas canvas, Size size) {
    if (_cachedParticles == null || _cachedParticles!.length < 2) return;

    final connectionDistance = 100.0;
    final connectionPaint = Paint()..strokeWidth = 0.5;

    // Only check a subset of particles for performance
    final step = max(1, (_cachedParticles!.length / 200).ceil());

    for (int i = 0; i < _cachedParticles!.length; i += step) {
      final p1 = _cachedParticles![i];

      for (int j = i + step; j < _cachedParticles!.length; j += step) {
        final p2 = _cachedParticles![j];

        final dx = p1.x - p2.x;
        final dy = p1.y - p2.y;
        final distance = sqrt(dx * dx + dy * dy);

        if (distance < connectionDistance) {
          final opacity = (1.0 - distance / connectionDistance) * 0.15;
          final avgHue = (p1.hue + p2.hue) / 2;

          connectionPaint.color = HSVColor.fromAHSV(
            opacity,
            avgHue,
            0.7,
            1.0,
          ).toColor();

          canvas.drawLine(
            Offset(p1.x, p1.y),
            Offset(p2.x, p2.y),
            connectionPaint,
          );
        }
      }
    }
  }

  /// Draw enhanced flow field grid with animated indicators
  void _drawFlowFieldGrid(Canvas canvas, Size size, double time) {
    final gridSize = 50.0;
    final cols = (size.width / gridSize).ceil();
    final rows = (size.height / gridSize).ceil();

    final linePaint = Paint()
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        final x = i * gridSize + gridSize / 2;
        final y = j * gridSize + gridSize / 2;

        final angle = _getEnhancedCurlNoise(
          x / size.width,
          y / size.height,
          time * flowSpeed * 0.05,
        );

        final length = 20.0;
        final x1 = x - cos(angle) * length / 2;
        final y1 = y - sin(angle) * length / 2;
        final x2 = x + cos(angle) * length / 2;
        final y2 = y + sin(angle) * length / 2;

        // Color based on angle with animation
        final colorHue = (hue + (angle / (2 * pi)) * 120 + time * 10) % 360;
        final opacity = 0.1 + (sin(time + i * 0.5 + j * 0.5) * 0.5 + 0.5) * 0.1;

        linePaint.color = HSVColor.fromAHSV(
          opacity,
          colorHue,
          0.6,
          1.0,
        ).toColor();

        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), linePaint);

        // Draw arrow head
        final arrowSize = 4.0;
        final arrowAngle = pi / 6;

        final arrow1X = x2 - cos(angle - arrowAngle) * arrowSize;
        final arrow1Y = y2 - sin(angle - arrowAngle) * arrowSize;
        final arrow2X = x2 - cos(angle + arrowAngle) * arrowSize;
        final arrow2Y = y2 - sin(angle + arrowAngle) * arrowSize;

        canvas.drawLine(Offset(x2, y2), Offset(arrow1X, arrow1Y), linePaint);
        canvas.drawLine(Offset(x2, y2), Offset(arrow2X, arrow2Y), linePaint);
      }
    }
  }

  /// Enhanced curl noise with 4 octaves for more organic patterns
  double _getEnhancedCurlNoise(double x, double y, double t) {
    double angle = 0;

    // First octave - large scale flow
    angle += _perlinNoise(x * 2, y * 2, t) * pi;

    // Second octave - medium scale turbulence
    angle += _perlinNoise(x * 4 + 100, y * 4 + 100, t * 0.7) * pi * 0.5;

    // Third octave - small scale detail
    angle += _perlinNoise(x * 8 + 200, y * 8 + 200, t * 0.5) * pi * 0.25;

    // Fourth octave - fine detail
    angle += _perlinNoise(x * 16 + 300, y * 16 + 300, t * 0.3) * pi * 0.125;

    return angle;
  }

  /// Improved Perlin-like noise function
  double _perlinNoise(double x, double y, double z) {
    // Multiple sine/cosine waves for better noise
    final n1 = sin(x * 1.7 + z * 1.2) * cos(y * 1.9);
    final n2 = sin(y * 2.3 + z * 0.8) * cos(x * 2.1);
    final n3 = sin((x + y) * 1.3 + z * 0.5) * cos((x - y) * 1.1);
    final n4 = sin(x * 0.9 + y * 1.1 + z * 1.5);

    return (n1 + n2 + n3 + n4) / 4.0;
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

/// Enhanced Flow particle with trail history
class FlowParticle {
  double x;
  double y;
  double hue;
  double speed;
  double size;
  List<Offset> trail;

  FlowParticle({
    required this.x,
    required this.y,
    required this.hue,
    this.speed = 1.0,
    this.size = 2.0,
  }) : trail = [];

  void addToTrail() {
    trail.add(Offset(x, y));
    if (trail.length > 20) {
      trail.removeAt(0);
    }
  }
}
