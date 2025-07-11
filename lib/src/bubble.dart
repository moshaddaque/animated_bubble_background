import 'package:flutter/material.dart';

/// Data class representing a bubble
class Bubble {
  /// Size of the bubble
  final double size;

  /// Color of the bubble
  final Color color;

  /// Opacity of the bubble (0.0 to 1.0)
  final double opacity;

  const Bubble({
    required this.size,
    required this.color,
    required this.opacity,
  });
}
