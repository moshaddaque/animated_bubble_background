import 'package:flutter/material.dart';
import 'bubble.dart';

/// Custom painter for drawing animated bubbles
class BubblePainter extends CustomPainter {
  final List<Animation<Offset>> animations;
  final List<Bubble> bubbles;
  final bool enableShimmer;

  BubblePainter({
    required this.animations,
    required this.bubbles,
    this.enableShimmer = true,
  }) : super(repaint: Listenable.merge(animations));

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < animations.length; i++) {
      final animation = animations[i];
      final bubble = bubbles[i];
      final position = animation.value;

      final x = position.dx * size.width;
      final y = position.dy * size.height;

      if (x < -bubble.size ||
          x > size.width + bubble.size ||
          y < -bubble.size ||
          y > size.height + bubble.size) {
        continue;
      }

      final paint = Paint()
        ..shader = RadialGradient(
          colors: [
            bubble.color.withValues(alpha: bubble.opacity),
            bubble.color.withValues(alpha: bubble.opacity * 0.3),
            bubble.color.withValues(alpha: 0.0),
          ],
          stops: const [0.0, 0.7, 1.0],
        ).createShader(Rect.fromCircle(
          center: Offset(x, y),
          radius: bubble.size / 2,
        ));

      canvas.drawCircle(
        Offset(x, y),
        bubble.size / 2,
        paint,
      );

      if (enableShimmer) {
        final shimmerPaint = Paint()
          ..color = Colors.white.withValues(alpha: bubble.opacity * 0.3)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

        canvas.drawCircle(
          Offset(x - bubble.size * 0.15, y - bubble.size * 0.15),
          bubble.size * 0.2,
          shimmerPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
