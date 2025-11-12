import 'package:flutter/material.dart';

/// Types of generative art
enum ArtType {
  frame('Frame', Icons.photo_size_select_large),
  waves('Waves', Icons.waves),
  fractals('Fractals', Icons.grid_on),
  noise('Noise Field', Icons.grain),
  flow('Flow Field', Icons.water),
  spirals('Spirals', Icons.rotate_right),
  particles('Particles', Icons.blur_on);

  final String name;
  final IconData icon;

  const ArtType(this.name, this.icon);
}
