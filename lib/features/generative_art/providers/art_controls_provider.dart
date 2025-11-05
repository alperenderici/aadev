import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:aad/features/generative_art/models/art_type.dart';

part 'art_controls_provider.g.dart';

/// Art type provider
@riverpod
class ArtTypeNotifier extends _$ArtTypeNotifier {
  @override
  ArtType build() => ArtType.particles;

  void setArtType(ArtType type) {
    state = type;
  }
}

/// Particle controls provider
@riverpod
class ParticleControls extends _$ParticleControls {
  @override
  ParticleControlsState build() => const ParticleControlsState();

  void setSpeed(double value) {
    state = state.copyWith(speed: value);
  }

  void setHue(double value) {
    state = state.copyWith(hue: value);
  }

  void setSize(double value) {
    state = state.copyWith(size: value);
  }
}

class ParticleControlsState {
  final double speed;
  final double hue;
  final double size;

  const ParticleControlsState({
    this.speed = 1.0,
    this.hue = 0.0,
    this.size = 1.0,
  });

  ParticleControlsState copyWith({
    double? speed,
    double? hue,
    double? size,
  }) {
    return ParticleControlsState(
      speed: speed ?? this.speed,
      hue: hue ?? this.hue,
      size: size ?? this.size,
    );
  }
}

/// Wave controls provider
@riverpod
class WaveControls extends _$WaveControls {
  @override
  WaveControlsState build() => const WaveControlsState();

  void setSpeed(double value) {
    state = state.copyWith(speed: value);
  }

  void setAmplitude(double value) {
    state = state.copyWith(amplitude: value);
  }

  void setFrequency(double value) {
    state = state.copyWith(frequency: value);
  }

  void setHue(double value) {
    state = state.copyWith(hue: value);
  }
}

class WaveControlsState {
  final double speed;
  final double amplitude;
  final double frequency;
  final double hue;

  const WaveControlsState({
    this.speed = 1.0,
    this.amplitude = 1.0,
    this.frequency = 1.0,
    this.hue = 0.0,
  });

  WaveControlsState copyWith({
    double? speed,
    double? amplitude,
    double? frequency,
    double? hue,
  }) {
    return WaveControlsState(
      speed: speed ?? this.speed,
      amplitude: amplitude ?? this.amplitude,
      frequency: frequency ?? this.frequency,
      hue: hue ?? this.hue,
    );
  }
}

/// Fractal controls provider
@riverpod
class FractalControls extends _$FractalControls {
  @override
  FractalControlsState build() => const FractalControlsState();

  void setDepth(double value) {
    state = state.copyWith(depth: value);
  }

  void setRotationSpeed(double value) {
    state = state.copyWith(rotationSpeed: value);
  }

  void setScale(double value) {
    state = state.copyWith(scale: value);
  }

  void setHue(double value) {
    state = state.copyWith(hue: value);
  }
}

class FractalControlsState {
  final double depth;
  final double rotationSpeed;
  final double scale;
  final double hue;

  const FractalControlsState({
    this.depth = 1.0,
    this.rotationSpeed = 1.0,
    this.scale = 1.0,
    this.hue = 0.0,
  });

  FractalControlsState copyWith({
    double? depth,
    double? rotationSpeed,
    double? scale,
    double? hue,
  }) {
    return FractalControlsState(
      depth: depth ?? this.depth,
      rotationSpeed: rotationSpeed ?? this.rotationSpeed,
      scale: scale ?? this.scale,
      hue: hue ?? this.hue,
    );
  }
}

/// Noise controls provider
@riverpod
class NoiseControls extends _$NoiseControls {
  @override
  NoiseControlsState build() => const NoiseControlsState();

  void setScale(double value) {
    state = state.copyWith(scale: value);
  }

  void setSpeed(double value) {
    state = state.copyWith(speed: value);
  }

  void setFlowStrength(double value) {
    state = state.copyWith(flowStrength: value);
  }

  void setHue(double value) {
    state = state.copyWith(hue: value);
  }
}

class NoiseControlsState {
  final double scale;
  final double speed;
  final double flowStrength;
  final double hue;

  const NoiseControlsState({
    this.scale = 1.0,
    this.speed = 1.0,
    this.flowStrength = 1.0,
    this.hue = 0.0,
  });

  NoiseControlsState copyWith({
    double? scale,
    double? speed,
    double? flowStrength,
    double? hue,
  }) {
    return NoiseControlsState(
      scale: scale ?? this.scale,
      speed: speed ?? this.speed,
      flowStrength: flowStrength ?? this.flowStrength,
      hue: hue ?? this.hue,
    );
  }
}

/// Spiral controls provider
@riverpod
class SpiralControls extends _$SpiralControls {
  @override
  SpiralControlsState build() => const SpiralControlsState();

  void setRotationSpeed(double value) {
    state = state.copyWith(rotationSpeed: value);
  }

  void setCount(double value) {
    state = state.copyWith(count: value);
  }

  void setRadius(double value) {
    state = state.copyWith(radius: value);
  }

  void setHue(double value) {
    state = state.copyWith(hue: value);
  }
}

class SpiralControlsState {
  final double rotationSpeed;
  final double count;
  final double radius;
  final double hue;

  const SpiralControlsState({
    this.rotationSpeed = 1.0,
    this.count = 1.0,
    this.radius = 1.0,
    this.hue = 0.0,
  });

  SpiralControlsState copyWith({
    double? rotationSpeed,
    double? count,
    double? radius,
    double? hue,
  }) {
    return SpiralControlsState(
      rotationSpeed: rotationSpeed ?? this.rotationSpeed,
      count: count ?? this.count,
      radius: radius ?? this.radius,
      hue: hue ?? this.hue,
    );
  }
}

/// Frame controls provider
@riverpod
class FrameControls extends _$FrameControls {
  @override
  FrameControlsState build() => const FrameControlsState();

  void setSpeed(double value) {
    state = state.copyWith(speed: value);
  }

  void setFlowIntensity(double value) {
    state = state.copyWith(flowIntensity: value);
  }

  void setParticleCount(double value) {
    state = state.copyWith(particleCount: value);
  }

  void setHue(double value) {
    state = state.copyWith(hue: value);
  }
}

class FrameControlsState {
  final double speed;
  final double flowIntensity;
  final double particleCount;
  final double hue;

  const FrameControlsState({
    this.speed = 1.0,
    this.flowIntensity = 1.0,
    this.particleCount = 1.0,
    this.hue = 0.0,
  });

  FrameControlsState copyWith({
    double? speed,
    double? flowIntensity,
    double? particleCount,
    double? hue,
  }) {
    return FrameControlsState(
      speed: speed ?? this.speed,
      flowIntensity: flowIntensity ?? this.flowIntensity,
      particleCount: particleCount ?? this.particleCount,
      hue: hue ?? this.hue,
    );
  }
}

