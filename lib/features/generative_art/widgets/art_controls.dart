import 'package:flutter/material.dart';

/// Generic Art Controls Widget - Reusable control panel for generative art
class ArtControls extends StatelessWidget {
  final String title;
  final List<ArtControlItem> controls;

  const ArtControls({
    super.key,
    required this.title,
    required this.controls,
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
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          ...controls.map((control) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _buildControl(control),
              )),
        ],
      ),
    );
  }

  Widget _buildControl(ArtControlItem control) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              control.icon,
              color: control.color ?? Colors.white70,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              control.label,
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
                color: (control.color ?? Colors.white).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                control.valueLabel,
                style: TextStyle(
                  color: control.color ?? Colors.white,
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
            activeTrackColor: control.color ?? Colors.white,
            inactiveTrackColor: Colors.white.withValues(alpha: 0.2),
            thumbColor: control.color ?? Colors.white,
            overlayColor: (control.color ?? Colors.white).withValues(alpha: 0.2),
            trackHeight: 4,
          ),
          child: Slider(
            value: control.value,
            min: control.min,
            max: control.max,
            onChanged: control.onChanged,
          ),
        ),
      ],
    );
  }
}

/// Art Control Item - Individual control configuration
class ArtControlItem {
  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final String valueLabel;
  final IconData icon;
  final Color? color;

  const ArtControlItem({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.valueLabel,
    required this.icon,
    this.color,
  });
}

