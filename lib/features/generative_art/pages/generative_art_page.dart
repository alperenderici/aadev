import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:aad/features/generative_art/widgets/generative_art_canvas.dart';
import 'package:aad/features/generative_art/models/art_type.dart';
import 'package:aad/features/generative_art/widgets/art_controls.dart';

/// Generative Art Page
class GenerativeArtPage extends HookWidget {
  const GenerativeArtPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < 600;

    // Art type state
    final selectedArtType = useState(ArtType.particles);

    // Control panel visibility for mobile
    final isControlPanelExpanded = useState(false);

    // Particle control parameters
    final particleSpeed = useState(1.0);
    final particleHue = useState(0.0);
    final particleSize = useState(1.0);

    // Waves control parameters
    final waveSpeed = useState(1.0);
    final waveAmplitude = useState(1.0);
    final waveFrequency = useState(1.0);
    final waveHue = useState(0.0);

    // Fractals control parameters
    final fractalDepth = useState(1.0);
    final fractalRotationSpeed = useState(1.0);
    final fractalScale = useState(1.0);
    final fractalHue = useState(0.0);

    // Noise control parameters
    final noiseScale = useState(1.0);
    final noiseSpeed = useState(1.0);
    final noiseFlowStrength = useState(1.0);
    final noiseHue = useState(0.0);

    // Spirals control parameters
    final spiralRotationSpeed = useState(1.0);
    final spiralCount = useState(1.0);
    final spiralRadius = useState(1.0);
    final spiralHue = useState(0.0);

    // Frame control parameters
    final frameSpeed = useState(1.0);
    final frameFlowIntensity = useState(1.0);
    final frameParticleCount = useState(1.0);
    final frameHue = useState(0.0);

    // Local function to build control panel
    Widget buildControlPanel() {
      switch (selectedArtType.value) {
        case ArtType.particles:
          return ArtControls(
            title: 'Particles',
            controls: [
              ArtControlItem(
                label: 'Speed',
                value: particleSpeed.value,
                min: 0.1,
                max: 3.0,
                onChanged: (value) => particleSpeed.value = value,
                valueLabel: '${particleSpeed.value.toStringAsFixed(1)}x',
                icon: Icons.speed,
                color: Colors.cyan,
              ),
              ArtControlItem(
                label: 'Color Hue',
                value: particleHue.value,
                min: 0,
                max: 360,
                onChanged: (value) => particleHue.value = value,
                valueLabel: '${particleHue.value.toStringAsFixed(0)}°',
                icon: Icons.palette,
                color: HSVColor.fromAHSV(
                  1.0,
                  particleHue.value,
                  0.8,
                  1.0,
                ).toColor(),
              ),
              ArtControlItem(
                label: 'Particle Size',
                value: particleSize.value,
                min: 0.5,
                max: 3.0,
                onChanged: (value) => particleSize.value = value,
                valueLabel: '${particleSize.value.toStringAsFixed(1)}x',
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
                value: waveSpeed.value,
                min: 0.1,
                max: 3.0,
                onChanged: (value) => waveSpeed.value = value,
                valueLabel: '${waveSpeed.value.toStringAsFixed(1)}x',
                icon: Icons.speed,
                color: Colors.cyan,
              ),
              ArtControlItem(
                label: 'Amplitude',
                value: waveAmplitude.value,
                min: 0.5,
                max: 2.0,
                onChanged: (value) => waveAmplitude.value = value,
                valueLabel: '${waveAmplitude.value.toStringAsFixed(1)}x',
                icon: Icons.waves,
                color: Colors.blue,
              ),
              ArtControlItem(
                label: 'Frequency',
                value: waveFrequency.value,
                min: 0.5,
                max: 3.0,
                onChanged: (value) => waveFrequency.value = value,
                valueLabel: '${waveFrequency.value.toStringAsFixed(1)}x',
                icon: Icons.graphic_eq,
                color: Colors.purple,
              ),
              ArtControlItem(
                label: 'Color Hue',
                value: waveHue.value,
                min: 0,
                max: 360,
                onChanged: (value) => waveHue.value = value,
                valueLabel: '${waveHue.value.toStringAsFixed(0)}°',
                icon: Icons.palette,
                color: HSVColor.fromAHSV(
                  1.0,
                  waveHue.value > 0 ? waveHue.value : 200,
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
                value: fractalDepth.value,
                min: 0.5,
                max: 2.0,
                onChanged: (value) => fractalDepth.value = value,
                valueLabel: '${fractalDepth.value.toStringAsFixed(1)}x',
                icon: Icons.layers,
                color: Colors.green,
              ),
              ArtControlItem(
                label: 'Rotation Speed',
                value: fractalRotationSpeed.value,
                min: 0.1,
                max: 3.0,
                onChanged: (value) => fractalRotationSpeed.value = value,
                valueLabel: '${fractalRotationSpeed.value.toStringAsFixed(1)}x',
                icon: Icons.rotate_right,
                color: Colors.orange,
              ),
              ArtControlItem(
                label: 'Scale',
                value: fractalScale.value,
                min: 0.5,
                max: 2.0,
                onChanged: (value) => fractalScale.value = value,
                valueLabel: '${fractalScale.value.toStringAsFixed(1)}x',
                icon: Icons.zoom_in,
                color: Colors.purple,
              ),
              ArtControlItem(
                label: 'Color Hue',
                value: fractalHue.value,
                min: 0,
                max: 360,
                onChanged: (value) => fractalHue.value = value,
                valueLabel: '${fractalHue.value.toStringAsFixed(0)}°',
                icon: Icons.palette,
                color: HSVColor.fromAHSV(
                  1.0,
                  fractalHue.value > 0 ? fractalHue.value : 280,
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
                label: 'Scale',
                value: noiseScale.value,
                min: 0.5,
                max: 3.0,
                onChanged: (value) => noiseScale.value = value,
                valueLabel: '${noiseScale.value.toStringAsFixed(1)}x',
                icon: Icons.grid_on,
                color: Colors.teal,
              ),
              ArtControlItem(
                label: 'Speed',
                value: noiseSpeed.value,
                min: 0.1,
                max: 3.0,
                onChanged: (value) => noiseSpeed.value = value,
                valueLabel: '${noiseSpeed.value.toStringAsFixed(1)}x',
                icon: Icons.speed,
                color: Colors.cyan,
              ),
              ArtControlItem(
                label: 'Flow Strength',
                value: noiseFlowStrength.value,
                min: 0.5,
                max: 2.0,
                onChanged: (value) => noiseFlowStrength.value = value,
                valueLabel: '${noiseFlowStrength.value.toStringAsFixed(1)}x',
                icon: Icons.water,
                color: Colors.blue,
              ),
              ArtControlItem(
                label: 'Color Hue',
                value: noiseHue.value,
                min: 0,
                max: 360,
                onChanged: (value) => noiseHue.value = value,
                valueLabel: '${noiseHue.value.toStringAsFixed(0)}°',
                icon: Icons.palette,
                color: HSVColor.fromAHSV(
                  1.0,
                  noiseHue.value > 0 ? noiseHue.value : 180,
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
                value: spiralRotationSpeed.value,
                min: 0.1,
                max: 3.0,
                onChanged: (value) => spiralRotationSpeed.value = value,
                valueLabel: '${spiralRotationSpeed.value.toStringAsFixed(1)}x',
                icon: Icons.rotate_right,
                color: Colors.orange,
              ),
              ArtControlItem(
                label: 'Spiral Count',
                value: spiralCount.value,
                min: 0.5,
                max: 2.0,
                onChanged: (value) => spiralCount.value = value,
                valueLabel: '${spiralCount.value.toStringAsFixed(1)}x',
                icon: Icons.filter_9_plus,
                color: Colors.purple,
              ),
              ArtControlItem(
                label: 'Radius',
                value: spiralRadius.value,
                min: 0.5,
                max: 2.0,
                onChanged: (value) => spiralRadius.value = value,
                valueLabel: '${spiralRadius.value.toStringAsFixed(1)}x',
                icon: Icons.circle_outlined,
                color: Colors.pink,
              ),
              ArtControlItem(
                label: 'Color Hue',
                value: spiralHue.value,
                min: 0,
                max: 360,
                onChanged: (value) => spiralHue.value = value,
                valueLabel: '${spiralHue.value.toStringAsFixed(0)}°',
                icon: Icons.palette,
                color: HSVColor.fromAHSV(
                  1.0,
                  spiralHue.value > 0 ? spiralHue.value : 300,
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
                label: 'Speed',
                value: frameSpeed.value,
                min: 0.1,
                max: 3.0,
                onChanged: (value) => frameSpeed.value = value,
                valueLabel: '${frameSpeed.value.toStringAsFixed(1)}x',
                icon: Icons.speed,
                color: Colors.cyan,
              ),
              ArtControlItem(
                label: 'Flow Intensity',
                value: frameFlowIntensity.value,
                min: 0.5,
                max: 2.0,
                onChanged: (value) => frameFlowIntensity.value = value,
                valueLabel: '${frameFlowIntensity.value.toStringAsFixed(1)}x',
                icon: Icons.water,
                color: Colors.blue,
              ),
              ArtControlItem(
                label: 'Particle Count',
                value: frameParticleCount.value,
                min: 0.5,
                max: 2.0,
                onChanged: (value) => frameParticleCount.value = value,
                valueLabel: '${frameParticleCount.value.toStringAsFixed(1)}x',
                icon: Icons.grain,
                color: Colors.purple,
              ),
              ArtControlItem(
                label: 'Color Hue',
                value: frameHue.value,
                min: 0,
                max: 360,
                onChanged: (value) => frameHue.value = value,
                valueLabel: '${frameHue.value.toStringAsFixed(0)}°',
                icon: Icons.palette,
                color: HSVColor.fromAHSV(
                  1.0,
                  frameHue.value > 0 ? frameHue.value : 200,
                  0.8,
                  1.0,
                ).toColor(),
              ),
            ],
          );
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          // Generative Art Background
          Positioned.fill(
            child: GenerativeArtCanvas(
              artType: selectedArtType.value,
              particleSpeed: particleSpeed.value,
              particleHue: particleHue.value,
              particleSize: particleSize.value,
              waveSpeed: waveSpeed.value,
              waveAmplitude: waveAmplitude.value,
              waveFrequency: waveFrequency.value,
              waveHue: waveHue.value,
              fractalDepth: fractalDepth.value,
              fractalRotationSpeed: fractalRotationSpeed.value,
              fractalScale: fractalScale.value,
              fractalHue: fractalHue.value,
              noiseScale: noiseScale.value,
              noiseSpeed: noiseSpeed.value,
              noiseFlowStrength: noiseFlowStrength.value,
              noiseHue: noiseHue.value,
              spiralRotationSpeed: spiralRotationSpeed.value,
              spiralCount: spiralCount.value,
              spiralRadius: spiralRadius.value,
              spiralHue: spiralHue.value,
              frameSpeed: frameSpeed.value,
              frameFlowIntensity: frameFlowIntensity.value,
              frameParticleCount: frameParticleCount.value,
              frameHue: frameHue.value,
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
          // On mobile: floating button that expands/collapses
          // On desktop: fixed panel on the right
          if (isMobile)
            Positioned(
              right: 16,
              top: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Floating toggle button
                  FloatingActionButton(
                    mini: true,
                    backgroundColor: theme.colorScheme.primary,
                    onPressed: () {
                      isControlPanelExpanded.value =
                          !isControlPanelExpanded.value;
                    },
                    child: Icon(
                      isControlPanelExpanded.value ? Icons.close : Icons.tune,
                      color: Colors.white,
                    ),
                  ),
                  // Expandable control panel
                  if (isControlPanelExpanded.value) ...[
                    const SizedBox(height: 8),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 280),
                      child: buildControlPanel(),
                    ),
                  ],
                ],
              ),
            )
          else
            Positioned(right: 24, top: 100, child: buildControlPanel()),

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
                        final isSelected = selectedArtType.value == artType;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: _ArtTypeButton(
                            artType: artType,
                            isSelected: isSelected,
                            onTap: () {
                              selectedArtType.value = artType;
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
}

class _ArtTypeButton extends HookWidget {
  final ArtType artType;
  final bool isSelected;
  final VoidCallback onTap;

  const _ArtTypeButton({
    required this.artType,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isHovered = useState(false);

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primary
                : isHovered.value
                ? Colors.white.withValues(alpha: 0.2)
                : Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? theme.colorScheme.primary
                  : Colors.white.withValues(alpha: 0.3),
              width: 2,
            ),
            boxShadow: isSelected || isHovered.value
                ? [
                    BoxShadow(
                      color:
                          (isSelected
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
              Icon(artType.icon, color: Colors.white, size: 32),
              const SizedBox(height: 8),
              Text(
                artType.name,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
