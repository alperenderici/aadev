import 'package:flutter/material.dart';
import 'package:aad/features/generative_art/widgets/generative_art_canvas.dart';
import 'package:aad/features/generative_art/models/art_type.dart';

/// Generative Art Page
class GenerativeArtPage extends StatefulWidget {
  const GenerativeArtPage({super.key});

  @override
  State<GenerativeArtPage> createState() => _GenerativeArtPageState();
}

class _GenerativeArtPageState extends State<GenerativeArtPage> {
  ArtType _selectedArtType = ArtType.particles;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // Generative Art Background
          Positioned.fill(
            child: GenerativeArtCanvas(artType: _selectedArtType),
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
                      color: (widget.isSelected
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
              Icon(
                widget.artType.icon,
                color: Colors.white,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                widget.artType.name,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight:
                      widget.isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

