import 'dart:math';
import 'package:flutter/material.dart';

/// Noise Painter - Perlin noise-like field visualization
class NoisePainter extends CustomPainter {
  final Animation<double> animation;
  final Random random;

  NoisePainter({
    required this.animation,
    required this.random,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final gridSize = 30;
    final cols = (size.width / gridSize).ceil();
    final rows = (size.height / gridSize).ceil();

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        final x = i * gridSize.toDouble();
        final y = j * gridSize.toDouble();

        // Generate noise value
        final noise = _noise(
          i * 0.1,
          j * 0.1,
          animation.value * 2,
        );

        // Convert noise to angle
        final angle = noise * 2 * pi;
        final magnitude = 15;

        final endX = x + cos(angle) * magnitude;
        final endY = y + sin(angle) * magnitude;

        // Color based on noise value
        final hue = (noise * 360 + animation.value * 360) % 360;
        final paint = Paint()
          ..color = HSVColor.fromAHSV(
            0.6,
            hue,
            0.8,
            1.0,
          ).toColor()
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round;

        canvas.drawLine(
          Offset(x, y),
          Offset(endX, endY),
          paint,
        );

        // Draw dots at grid points
        final dotPaint = Paint()
          ..color = paint.color.withValues(alpha: 0.8)
          ..style = PaintingStyle.fill;

        canvas.drawCircle(
          Offset(x, y),
          2,
          dotPaint,
        );
      }
    }
  }

  // Simple noise function (pseudo-Perlin noise)
  double _noise(double x, double y, double z) {
    final X = x.floor();
    final Y = y.floor();
    final Z = z.floor();

    final xf = x - X;
    final yf = y - Y;
    final zf = z - Z;

    final u = _fade(xf);
    final v = _fade(yf);
    final w = _fade(zf);

    final a = _hash(X) + Y;
    final aa = _hash(a) + Z;
    final ab = _hash(a + 1) + Z;
    final b = _hash(X + 1) + Y;
    final ba = _hash(b) + Z;
    final bb = _hash(b + 1) + Z;

    return _lerp(
      w,
      _lerp(
        v,
        _lerp(u, _grad(aa, xf, yf, zf), _grad(ba, xf - 1, yf, zf)),
        _lerp(u, _grad(ab, xf, yf - 1, zf), _grad(bb, xf - 1, yf - 1, zf)),
      ),
      _lerp(
        v,
        _lerp(u, _grad(aa + 1, xf, yf, zf - 1), _grad(ba + 1, xf - 1, yf, zf - 1)),
        _lerp(u, _grad(ab + 1, xf, yf - 1, zf - 1), _grad(bb + 1, xf - 1, yf - 1, zf - 1)),
      ),
    );
  }

  double _fade(double t) {
    return t * t * t * (t * (t * 6 - 15) + 10);
  }

  double _lerp(double t, double a, double b) {
    return a + t * (b - a);
  }

  int _hash(int x) {
    return ((x * 1619) % 256).abs();
  }

  double _grad(int hash, double x, double y, double z) {
    final h = hash & 15;
    final u = h < 8 ? x : y;
    final v = h < 4 ? y : (h == 12 || h == 14 ? x : z);
    return ((h & 1) == 0 ? u : -u) + ((h & 2) == 0 ? v : -v);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

