import 'package:flutter/material.dart';

/// Particle Controls Widget - Interactive controls for particle art
class ParticleControls extends StatelessWidget {
  final double speed;
  final double hue;
  final double particleSize;
  final ValueChanged<double> onSpeedChanged;
  final ValueChanged<double> onHueChanged;
  final ValueChanged<double> onParticleSizeChanged;

  const ParticleControls({
    super.key,
    required this.speed,
    required this.hue,
    required this.particleSize,
    required this.onSpeedChanged,
    required this.onHueChanged,
    required this.onParticleSizeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Particle Controls',
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          // Speed Control
          _buildControl(
            label: 'Speed',
            value: speed,
            min: 0.1,
            max: 3.0,
            onChanged: onSpeedChanged,
            valueLabel: '${speed.toStringAsFixed(1)}x',
            icon: Icons.speed,
          ),
          const SizedBox(height: 20),

          // Hue Control
          _buildControl(
            label: 'Color Hue',
            value: hue,
            min: 0,
            max: 360,
            onChanged: onHueChanged,
            valueLabel: '${hue.toInt()}°',
            icon: Icons.palette,
            color: HSVColor.fromAHSV(1.0, hue, 0.8, 1.0).toColor(),
          ),
          const SizedBox(height: 20),

          // Particle Size Control
          _buildControl(
            label: 'Particle Size',
            value: particleSize,
            min: 0.5,
            max: 3.0,
            onChanged: onParticleSizeChanged,
            valueLabel: '${particleSize.toStringAsFixed(1)}x',
            icon: Icons.circle,
          ),
        ],
      ),
    );
  }

  Widget _buildControl({
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
    required String valueLabel,
    required IconData icon,
    Color? color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: color ?? Colors.white70,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: (color ?? Colors.white).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                valueLabel,
                style: TextStyle(
                  color: color ?? Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: color ?? Colors.white,
            inactiveTrackColor: Colors.white.withValues(alpha: 0.2),
            thumbColor: color ?? Colors.white,
            overlayColor: (color ?? Colors.white).withValues(alpha: 0.2),
            trackHeight: 4,
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

