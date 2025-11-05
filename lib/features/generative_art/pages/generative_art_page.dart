import 'package:flutter/material.dart';
import 'package:aad/features/generative_art/widgets/generative_art_canvas.dart';
import 'package:aad/features/generative_art/models/art_type.dart';
import 'package:aad/features/generative_art/widgets/art_controls.dart';

/// Generative Art Page
class GenerativeArtPage extends StatefulWidget {
  const GenerativeArtPage({super.key});

  @override
  State<GenerativeArtPage> createState() => _GenerativeArtPageState();
}

class _GenerativeArtPageState extends State<GenerativeArtPage> {
  ArtType _selectedArtType = ArtType.particles;

  // Particle control parameters
  double _particleSpeed = 1.0;
  double _particleHue = 0.0;
  double _particleSize = 1.0;

  // Waves control parameters
  double _waveSpeed = 1.0;
  double _waveAmplitude = 1.0;
  double _waveFrequency = 1.0;
  double _waveHue = 0.0;

  // Fractals control parameters
  double _fractalDepth = 1.0;
  double _fractalRotationSpeed = 1.0;
  double _fractalScale = 1.0;
  double _fractalHue = 0.0;

  // Noise control parameters
  double _noiseScale = 1.0;
  double _noiseSpeed = 1.0;
  double _noiseFlowStrength = 1.0;
  double _noiseHue = 0.0;

  // Spirals control parameters
  double _spiralRotationSpeed = 1.0;
  double _spiralCount = 1.0;
  double _spiralRadius = 1.0;
  double _spiralHue = 0.0;

  // Frame control parameters
  double _frameSpeed = 1.0;
  double _frameFlowIntensity = 1.0;
  double _frameParticleCount = 1.0;
  double _frameHue = 0.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // Generative Art Background
          Positioned.fill(
            child: GenerativeArtCanvas(
              artType: _selectedArtType,
              particleSpeed: _particleSpeed,
              particleHue: _particleHue,
              particleSize: _particleSize,
              waveSpeed: _waveSpeed,
              waveAmplitude: _waveAmplitude,
              waveFrequency: _waveFrequency,
              waveHue: _waveHue,
              fractalDepth: _fractalDepth,
              fractalRotationSpeed: _fractalRotationSpeed,
              fractalScale: _fractalScale,
              fractalHue: _fractalHue,
              noiseScale: _noiseScale,
              noiseSpeed: _noiseSpeed,
              noiseFlowStrength: _noiseFlowStrength,
              noiseHue: _noiseHue,
              spiralRotationSpeed: _spiralRotationSpeed,
              spiralCount: _spiralCount,
              spiralRadius: _spiralRadius,
              spiralHue: _spiralHue,
              frameSpeed: _frameSpeed,
              frameFlowIntensity: _frameFlowIntensity,
              frameParticleCount: _frameParticleCount,
              frameHue: _frameHue,
            ),
          ),

          // Top Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.7),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Row(
                children: [
                  // Back Button
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 16),
                  // Title
                  Text(
                    'd_art',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const Spacer(),
                  // Info Text
                  Text(
                    'Generative Art Gallery',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Art Controls Panel (changes based on selected art type)
          Positioned(right: 24, top: 100, child: _buildControlPanel()),

          // Bottom Art Selection Panel
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.8),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Select Art Style',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: ArtType.values.map((artType) {
                        final isSelected = _selectedArtType == artType;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: _ArtTypeButton(
                            artType: artType,
                            isSelected: isSelected,
                            onTap: () {
                              setState(() {
                                _selectedArtType = artType;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build control panel based on selected art type
  Widget _buildControlPanel() {
    switch (_selectedArtType) {
      case ArtType.particles:
        return ArtControls(
          title: 'Particles',
          controls: [
            ArtControlItem(
              label: 'Speed',
              value: _particleSpeed,
              min: 0.1,
              max: 3.0,
              onChanged: (value) => setState(() => _particleSpeed = value),
              valueLabel: '${_particleSpeed.toStringAsFixed(1)}x',
              icon: Icons.speed,
              color: Colors.cyan,
            ),
            ArtControlItem(
              label: 'Color Hue',
              value: _particleHue,
              min: 0,
              max: 360,
              onChanged: (value) => setState(() => _particleHue = value),
              valueLabel: '${_particleHue.toStringAsFixed(0)}°',
              icon: Icons.palette,
              color: HSVColor.fromAHSV(1.0, _particleHue, 0.8, 1.0).toColor(),
            ),
            ArtControlItem(
              label: 'Particle Size',
              value: _particleSize,
              min: 0.5,
              max: 3.0,
              onChanged: (value) => setState(() => _particleSize = value),
              valueLabel: '${_particleSize.toStringAsFixed(1)}x',
              icon: Icons.circle,
              color: Colors.purple,
            ),
          ],
        );
      case ArtType.waves:
        return ArtControls(
          title: 'Waves',
          controls: [
            ArtControlItem(
              label: 'Speed',
              value: _waveSpeed,
              min: 0.1,
              max: 3.0,
              onChanged: (value) => setState(() => _waveSpeed = value),
              valueLabel: '${_waveSpeed.toStringAsFixed(1)}x',
              icon: Icons.speed,
              color: Colors.cyan,
            ),
            ArtControlItem(
              label: 'Amplitude',
              value: _waveAmplitude,
              min: 0.5,
              max: 2.0,
              onChanged: (value) => setState(() => _waveAmplitude = value),
              valueLabel: '${_waveAmplitude.toStringAsFixed(1)}x',
              icon: Icons.waves,
              color: Colors.blue,
            ),
            ArtControlItem(
              label: 'Frequency',
              value: _waveFrequency,
              min: 0.5,
              max: 2.0,
              onChanged: (value) => setState(() => _waveFrequency = value),
              valueLabel: '${_waveFrequency.toStringAsFixed(1)}x',
              icon: Icons.graphic_eq,
              color: Colors.teal,
            ),
            ArtControlItem(
              label: 'Color Hue',
              value: _waveHue,
              min: 0,
              max: 360,
              onChanged: (value) => setState(() => _waveHue = value),
              valueLabel: '${_waveHue.toStringAsFixed(0)}°',
              icon: Icons.palette,
              color: HSVColor.fromAHSV(
                1.0,
                _waveHue > 0 ? _waveHue : 180,
                0.8,
                1.0,
              ).toColor(),
            ),
          ],
        );
      case ArtType.fractals:
        return ArtControls(
          title: 'Fractals',
          controls: [
            ArtControlItem(
              label: 'Depth',
              value: _fractalDepth,
              min: 0.5,
              max: 1.5,
              onChanged: (value) => setState(() => _fractalDepth = value),
              valueLabel: '${(_fractalDepth * 10).toInt()}',
              icon: Icons.account_tree,
              color: Colors.green,
            ),
            ArtControlItem(
              label: 'Rotation Speed',
              value: _fractalRotationSpeed,
              min: 0.1,
              max: 3.0,
              onChanged: (value) =>
                  setState(() => _fractalRotationSpeed = value),
              valueLabel: '${_fractalRotationSpeed.toStringAsFixed(1)}x',
              icon: Icons.rotate_right,
              color: Colors.orange,
            ),
            ArtControlItem(
              label: 'Scale',
              value: _fractalScale,
              min: 0.5,
              max: 2.0,
              onChanged: (value) => setState(() => _fractalScale = value),
              valueLabel: '${_fractalScale.toStringAsFixed(1)}x',
              icon: Icons.zoom_out_map,
              color: Colors.amber,
            ),
            ArtControlItem(
              label: 'Color Hue',
              value: _fractalHue,
              min: 0,
              max: 360,
              onChanged: (value) => setState(() => _fractalHue = value),
              valueLabel: '${_fractalHue.toStringAsFixed(0)}°',
              icon: Icons.palette,
              color: HSVColor.fromAHSV(
                1.0,
                _fractalHue > 0 ? _fractalHue : 120,
                0.8,
                1.0,
              ).toColor(),
            ),
          ],
        );
      case ArtType.noise:
        return ArtControls(
          title: 'Noise Field',
          controls: [
            ArtControlItem(
              label: 'Noise Scale',
              value: _noiseScale,
              min: 0.5,
              max: 2.0,
              onChanged: (value) => setState(() => _noiseScale = value),
              valueLabel: '${_noiseScale.toStringAsFixed(1)}x',
              icon: Icons.grain,
              color: Colors.grey,
            ),
            ArtControlItem(
              label: 'Speed',
              value: _noiseSpeed,
              min: 0.1,
              max: 3.0,
              onChanged: (value) => setState(() => _noiseSpeed = value),
              valueLabel: '${_noiseSpeed.toStringAsFixed(1)}x',
              icon: Icons.speed,
              color: Colors.cyan,
            ),
            ArtControlItem(
              label: 'Flow Strength',
              value: _noiseFlowStrength,
              min: 0.5,
              max: 2.0,
              onChanged: (value) => setState(() => _noiseFlowStrength = value),
              valueLabel: '${_noiseFlowStrength.toStringAsFixed(1)}x',
              icon: Icons.water_drop,
              color: Colors.blueGrey,
            ),
            ArtControlItem(
              label: 'Color Hue',
              value: _noiseHue,
              min: 0,
              max: 360,
              onChanged: (value) => setState(() => _noiseHue = value),
              valueLabel: '${_noiseHue.toStringAsFixed(0)}°',
              icon: Icons.palette,
              color: HSVColor.fromAHSV(
                1.0,
                _noiseHue > 0 ? _noiseHue : 60,
                0.8,
                1.0,
              ).toColor(),
            ),
          ],
        );
      case ArtType.spirals:
        return ArtControls(
          title: 'Spirals',
          controls: [
            ArtControlItem(
              label: 'Rotation Speed',
              value: _spiralRotationSpeed,
              min: 0.1,
              max: 3.0,
              onChanged: (value) =>
                  setState(() => _spiralRotationSpeed = value),
              valueLabel: '${_spiralRotationSpeed.toStringAsFixed(1)}x',
              icon: Icons.rotate_right,
              color: Colors.orange,
            ),
            ArtControlItem(
              label: 'Spiral Count',
              value: _spiralCount,
              min: 0.2,
              max: 2.0,
              onChanged: (value) => setState(() => _spiralCount = value),
              valueLabel: '${(_spiralCount * 5).toInt()}',
              icon: Icons.all_inclusive,
              color: Colors.pink,
            ),
            ArtControlItem(
              label: 'Radius',
              value: _spiralRadius,
              min: 0.5,
              max: 1.5,
              onChanged: (value) => setState(() => _spiralRadius = value),
              valueLabel: '${_spiralRadius.toStringAsFixed(1)}x',
              icon: Icons.circle_outlined,
              color: Colors.deepPurple,
            ),
            ArtControlItem(
              label: 'Color Hue',
              value: _spiralHue,
              min: 0,
              max: 360,
              onChanged: (value) => setState(() => _spiralHue = value),
              valueLabel: '${_spiralHue.toStringAsFixed(0)}°',
              icon: Icons.palette,
              color: HSVColor.fromAHSV(
                1.0,
                _spiralHue > 0 ? _spiralHue : 280,
                0.8,
                1.0,
              ).toColor(),
            ),
          ],
        );
      case ArtType.frame:
        return ArtControls(
          title: 'Frame',
          controls: [
            ArtControlItem(
              label: 'Wave Speed',
              value: _frameSpeed,
              min: 0.1,
              max: 3.0,
              onChanged: (value) => setState(() => _frameSpeed = value),
              valueLabel: '${_frameSpeed.toStringAsFixed(1)}x',
              icon: Icons.speed,
              color: Colors.cyan,
            ),
            ArtControlItem(
              label: 'Flow Intensity',
              value: _frameFlowIntensity,
              min: 0.5,
              max: 2.0,
              onChanged: (value) => setState(() => _frameFlowIntensity = value),
              valueLabel: '${_frameFlowIntensity.toStringAsFixed(1)}x',
              icon: Icons.water,
              color: Colors.blue,
            ),
            ArtControlItem(
              label: 'Particle Count',
              value: _frameParticleCount,
              min: 0.2,
              max: 4.0,
              onChanged: (value) => setState(() => _frameParticleCount = value),
              valueLabel: '${(_frameParticleCount * 50).toInt()}',
              icon: Icons.grain,
              color: Colors.lightBlue,
            ),
            ArtControlItem(
              label: 'Color Hue',
              value: _frameHue,
              min: 0,
              max: 360,
              onChanged: (value) => setState(() => _frameHue = value),
              valueLabel: '${_frameHue.toStringAsFixed(0)}°',
              icon: Icons.palette,
              color: HSVColor.fromAHSV(
                1.0,
                _frameHue > 0 ? _frameHue : 200,
                0.8,
                1.0,
              ).toColor(),
            ),
          ],
        );
    }
  }
}

class _ArtTypeButton extends StatefulWidget {
  final ArtType artType;
  final bool isSelected;
  final VoidCallback onTap;

  const _ArtTypeButton({
    required this.artType,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_ArtTypeButton> createState() => _ArtTypeButtonState();
}

class _ArtTypeButtonState extends State<_ArtTypeButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? theme.colorScheme.primary
                : _isHovered
                ? Colors.white.withValues(alpha: 0.2)
                : Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.isSelected
                  ? theme.colorScheme.primary
                  : Colors.white.withValues(alpha: 0.3),
              width: 2,
            ),
            boxShadow: widget.isSelected || _isHovered
                ? [
                    BoxShadow(
                      color:
                          (widget.isSelected
                                  ? theme.colorScheme.primary
                                  : Colors.white)
                              .withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Column(
            children: [
              Icon(widget.artType.icon, color: Colors.white, size: 32),
              const SizedBox(height: 8),
              Text(
                widget.artType.name,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: widget.isSelected
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
