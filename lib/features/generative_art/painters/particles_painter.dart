import 'dart:math';
import 'package:flutter/material.dart';

/// Particles Painter - Animated particle system
class ParticlesPainter extends CustomPainter {
  final Animation<double> animation;
  final Random random;
  late final List<Particle> particles;

  ParticlesPainter({
    required this.animation,
    required this.random,
  }) : super(repaint: animation) {
    particles = List.generate(
      150,
      (index) => Particle(random),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final particle in particles) {
      particle.update(animation.value, size);

      // Draw particle with glow effect
      final glowPaint = Paint()
        ..color = particle.color.withValues(alpha: 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

      canvas.drawCircle(
        Offset(particle.x, particle.y),
        particle.size * 2,
        glowPaint,
      );

      paint.color = particle.color;
      canvas.drawCircle(
        Offset(particle.x, particle.y),
        particle.size,
        paint,
      );

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

  Particle(Random random) {
    x = random.nextDouble() * 2000;
    y = random.nextDouble() * 2000;
    vx = (random.nextDouble() - 0.5) * 2;
    vy = (random.nextDouble() - 0.5) * 2;
    size = random.nextDouble() * 3 + 2;
    phase = random.nextDouble() * 2 * pi;

    // Generate vibrant colors
    final hue = random.nextDouble() * 360;
    color = HSVColor.fromAHSV(1.0, hue, 0.8, 1.0).toColor();
  }

  void update(double time, Size size) {
    // Update position with smooth motion
    x += vx + sin(time * 2 * pi + phase) * 0.5;
    y += vy + cos(time * 2 * pi + phase) * 0.5;

    // Wrap around screen edges
    if (x < 0) x = size.width;
    if (x > size.width) x = 0;
    if (y < 0) y = size.height;
    if (y > size.height) y = 0;
  }
}

