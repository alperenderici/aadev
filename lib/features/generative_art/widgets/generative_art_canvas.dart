import 'dart:math';
import 'package:flutter/material.dart';
import 'package:aad/features/generative_art/models/art_type.dart';
import 'package:aad/features/generative_art/painters/particles_painter.dart';
import 'package:aad/features/generative_art/painters/waves_painter.dart';
import 'package:aad/features/generative_art/painters/fractals_painter.dart';
import 'package:aad/features/generative_art/painters/noise_painter.dart';
import 'package:aad/features/generative_art/painters/spirals_painter.dart';
import 'package:aad/features/generative_art/painters/frame_painter.dart';

/// Generative Art Canvas Widget
class GenerativeArtCanvas extends StatefulWidget {
  final ArtType artType;
  final double particleSpeed;
  final double particleHue;
  final double particleSize;

  const GenerativeArtCanvas({
    super.key,
    required this.artType,
    this.particleSpeed = 1.0,
    this.particleHue = 0.0,
    this.particleSize = 1.0,
  });

  @override
  State<GenerativeArtCanvas> createState() => _GenerativeArtCanvasState();
}

class _GenerativeArtCanvasState extends State<GenerativeArtCanvas>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      child: Container(
        key: ValueKey(widget.artType),
        color: Colors.black,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(painter: _getPainter(), size: Size.infinite);
          },
        ),
      ),
    );
  }

  CustomPainter _getPainter() {
    switch (widget.artType) {
      case ArtType.particles:
        return ParticlesPainter(
          animation: _controller,
          random: _random,
          speed: widget.particleSpeed,
          hue: widget.particleHue,
          particleSize: widget.particleSize,
        );
      case ArtType.waves:
        return WavesPainter(animation: _controller, random: _random);
      case ArtType.fractals:
        return FractalsPainter(animation: _controller, random: _random);
      case ArtType.noise:
        return NoisePainter(animation: _controller, random: _random);
      case ArtType.spirals:
        return SpiralsPainter(animation: _controller, random: _random);
      case ArtType.frame:
        return FramePainter(animation: _controller, random: _random);
    }
  }
}
