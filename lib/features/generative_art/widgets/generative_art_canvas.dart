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

  // Particle controls
  final double particleSpeed;
  final double particleHue;
  final double particleSize;

  // Waves controls
  final double waveSpeed;
  final double waveAmplitude;
  final double waveFrequency;
  final double waveHue;

  // Fractals controls
  final double fractalDepth;
  final double fractalRotationSpeed;
  final double fractalScale;
  final double fractalHue;

  // Noise controls
  final double noiseScale;
  final double noiseSpeed;
  final double noiseFlowStrength;
  final double noiseHue;

  // Spirals controls
  final double spiralRotationSpeed;
  final double spiralCount;
  final double spiralRadius;
  final double spiralHue;

  // Frame controls
  final double frameSpeed;
  final double frameFlowIntensity;
  final double frameParticleCount;
  final double frameHue;

  const GenerativeArtCanvas({
    super.key,
    required this.artType,
    this.particleSpeed = 1.0,
    this.particleHue = 0.0,
    this.particleSize = 1.0,
    this.waveSpeed = 1.0,
    this.waveAmplitude = 1.0,
    this.waveFrequency = 1.0,
    this.waveHue = 0.0,
    this.fractalDepth = 1.0,
    this.fractalRotationSpeed = 1.0,
    this.fractalScale = 1.0,
    this.fractalHue = 0.0,
    this.noiseScale = 1.0,
    this.noiseSpeed = 1.0,
    this.noiseFlowStrength = 1.0,
    this.noiseHue = 0.0,
    this.spiralRotationSpeed = 1.0,
    this.spiralCount = 1.0,
    this.spiralRadius = 1.0,
    this.spiralHue = 0.0,
    this.frameSpeed = 1.0,
    this.frameFlowIntensity = 1.0,
    this.frameParticleCount = 1.0,
    this.frameHue = 0.0,
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
        return WavesPainter(
          animation: _controller,
          random: _random,
          speed: widget.waveSpeed,
          amplitude: widget.waveAmplitude,
          frequency: widget.waveFrequency,
          hue: widget.waveHue,
        );
      case ArtType.fractals:
        return FractalsPainter(
          animation: _controller,
          random: _random,
          depth: widget.fractalDepth,
          rotationSpeed: widget.fractalRotationSpeed,
          scale: widget.fractalScale,
          hue: widget.fractalHue,
        );
      case ArtType.noise:
        return NoisePainter(
          animation: _controller,
          random: _random,
          noiseScale: widget.noiseScale,
          speed: widget.noiseSpeed,
          flowStrength: widget.noiseFlowStrength,
          hue: widget.noiseHue,
        );
      case ArtType.spirals:
        return SpiralsPainter(
          animation: _controller,
          random: _random,
          rotationSpeed: widget.spiralRotationSpeed,
          spiralCount: widget.spiralCount,
          radius: widget.spiralRadius,
          hue: widget.spiralHue,
        );
      case ArtType.frame:
        return FramePainter(
          animation: _controller,
          random: _random,
          speed: widget.frameSpeed,
          flowIntensity: widget.frameFlowIntensity,
          particleCount: widget.frameParticleCount,
          hue: widget.frameHue,
        );
    }
  }
}
