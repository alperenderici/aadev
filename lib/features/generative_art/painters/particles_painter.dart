import 'dart:math';
import 'package:flutter/material.dart';

/// Particles Painter - Animated particle system
class ParticlesPainter extends CustomPainter {
  final Animation<double> animation;
  final Random random;
  final double speed;
  final double hue;
  final double particleSize;
  late final List<Particle> particles;

  ParticlesPainter({
    required this.animation,
    required this.random,
    this.speed = 1.0,
    this.hue = 0.0,
    this.particleSize = 1.0,
  }) : super(repaint: animation) {
    particles = List.generate(
      150,
      (index) => Particle(random, baseHue: hue, sizeMultiplier: particleSize),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final particle in particles) {
      particle.update(animation.value, size, speed);

      // Apply hue shift if specified
      final particleColor = hue > 0
          ? HSVColor.fromAHSV(
              1.0,
              (particle.baseHue + hue) % 360,
              0.8,
              1.0,
            ).toColor()
          : particle.color;

      // Draw particle with glow effect
      final glowPaint = Paint()
        ..color = particleColor.withValues(alpha: 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

      canvas.drawCircle(
        Offset(particle.x, particle.y),
        particle.size * 2,
        glowPaint,
      );

      paint.color = particleColor;
      canvas.drawCircle(Offset(particle.x, particle.y), particle.size, paint);

      // Draw connections between nearby particles
      for (final other in particles) {
        final distance = sqrt(
          pow(particle.x - other.x, 2) + pow(particle.y - other.y, 2),
        );

        if (distance < 150 && distance > 0) {
          final linePaint = Paint()
            ..color = particle.color.withValues(
              alpha: (1 - distance / 150) * 0.3,
            )
            ..strokeWidth = 1;

          canvas.drawLine(
            Offset(particle.x, particle.y),
            Offset(other.x, other.y),
            linePaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Particle {
  late double x;
  late double y;
  late double vx;
  late double vy;
  late double size;
  late Color color;
  late double phase;
  late double baseHue;

  Particle(Random random, {double baseHue = 0.0, double sizeMultiplier = 1.0}) {
    x = random.nextDouble() * 2000;
    y = random.nextDouble() * 2000;
    vx = (random.nextDouble() - 0.5) * 2;
    vy = (random.nextDouble() - 0.5) * 2;
    size = (random.nextDouble() * 3 + 2) * sizeMultiplier;
    phase = random.nextDouble() * 2 * pi;

    // Generate vibrant colors
    this.baseHue = baseHue > 0 ? baseHue : random.nextDouble() * 360;
    color = HSVColor.fromAHSV(1.0, this.baseHue, 0.8, 1.0).toColor();
  }

  void update(double time, Size size, double speedMultiplier) {
    // Update position with smooth motion, applying speed multiplier
    x += (vx + sin(time * 2 * pi + phase) * 0.5) * speedMultiplier;
    y += (vy + cos(time * 2 * pi + phase) * 0.5) * speedMultiplier;

    // Wrap around screen edges
    if (x < 0) x = size.width;
    if (x > size.width) x = 0;
    if (y < 0) y = size.height;
    if (y > size.height) y = 0;
  }
}
