import 'package:flutter/material.dart';

/// Types of generative art
enum ArtType {
  particles('Particles', Icons.blur_on),
  waves('Waves', Icons.waves),
  fractals('Fractals', Icons.grid_on),
  noise('Noise Field', Icons.grain),
  spirals('Spirals', Icons.rotate_right),
  frame('Frame', Icons.photo_size_select_large);

  final String name;
  final IconData icon;

  const ArtType(this.name, this.icon);
}
