import 'dart:math';
import 'package:flutter/material.dart';
import 'bubble.dart';
import 'bubble_painter.dart';

/// A beautiful animated bubble background widget
///
/// This widget creates floating bubbles that continuously animate
/// from bottom to top of the screen with customizable properties.
class AnimatedBubbleBackground extends StatefulWidget {
  /// The child widget to display over the bubble background
  final Widget child;

  /// Number of bubbles to display (default: 15)
  final int bubbleCount;

  /// Custom colors for bubbles (optional)
  final List<Color>? bubbleColors;

  /// Minimum bubble size (default: 20.0)
  final double minBubbleSize;

  /// Maximum bubble size (default: 80.0)
  final double maxBubbleSize;

  /// Duration for complete bubble animation cycle (default: 20 seconds)
  final Duration animationDuration;

  /// Whether to enable bubble shimmer effect (default: true)
  final bool enableShimmer;

  /// Bubble opacity range (default: 0.1 to 0.5)
  final double minOpacity;
  final double maxOpacity;

  const AnimatedBubbleBackground({
    super.key,
    required this.child,
    this.bubbleCount = 15,
    this.bubbleColors,
    this.minBubbleSize = 20.0,
    this.maxBubbleSize = 80.0,
    this.animationDuration = const Duration(seconds: 20),
    this.enableShimmer = true,
    this.minOpacity = 0.1,
    this.maxOpacity = 0.5,
  })  : assert(bubbleCount > 0, 'bubbleCount must be positive'),
        assert(minBubbleSize > 0, 'minBubbleSize must be positive'),
        assert(maxBubbleSize > minBubbleSize,
            'maxBubbleSize must be greater than minBubbleSize'),
        assert(minOpacity >= 0 && minOpacity <= 1,
            'minOpacity must be between 0 and 1'),
        assert(maxOpacity >= minOpacity && maxOpacity <= 1,
            'maxOpacity must be between minOpacity and 1');

  @override
  State<AnimatedBubbleBackground> createState() =>
      _AnimatedBubbleBackgroundState();
}

class _AnimatedBubbleBackgroundState extends State<AnimatedBubbleBackground>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _animations;
  late List<Bubble> _bubbles;

  @override
  void initState() {
    super.initState();
    _initializeBubbles();
  }

  void _initializeBubbles() {
    _controllers = [];
    _animations = [];
    _bubbles = [];

    final random = Random();

    for (int i = 0; i < widget.bubbleCount; i++) {
      final controller = AnimationController(
        duration: Duration(
          seconds: widget.animationDuration.inSeconds + random.nextInt(10) - 5,
        ),
        vsync: this,
      );

      final startX = random.nextDouble() * 2 - 0.5;
      final startY = 1.2 + random.nextDouble() * 0.5;
      final endX = random.nextDouble() * 2 - 0.5;
      final endY = -0.5 - random.nextDouble() * 0.5;

      final animation = Tween<Offset>(
        begin: Offset(startX, startY),
        end: Offset(endX, endY),
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ));

      final bubble = Bubble(
        size: widget.minBubbleSize +
            random.nextDouble() * (widget.maxBubbleSize - widget.minBubbleSize),
        color:
            widget.bubbleColors?[random.nextInt(widget.bubbleColors!.length)] ??
                _getRandomColor(),
        opacity: widget.minOpacity +
            random.nextDouble() * (widget.maxOpacity - widget.minOpacity),
      );

      _controllers.add(controller);
      _animations.add(animation);
      _bubbles.add(bubble);

      Future.delayed(Duration(milliseconds: random.nextInt(5000)), () {
        if (mounted) {
          _startBubbleAnimation(i);
        }
      });
    }
  }

  void _startBubbleAnimation(int index) {
    final controller = _controllers[index];
    final random = Random();

    controller.forward().then((_) {
      if (mounted) {
        final startX = random.nextDouble() * 2 - 0.5;
        final startY = 1.2 + random.nextDouble() * 0.5;
        final endX = random.nextDouble() * 2 - 0.5;
        final endY = -0.5 - random.nextDouble() * 0.5;

        _animations[index] = Tween<Offset>(
          begin: Offset(startX, startY),
          end: Offset(endX, endY),
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Curves.linear,
        ));

        _bubbles[index] = Bubble(
          size: widget.minBubbleSize +
              random.nextDouble() *
                  (widget.maxBubbleSize - widget.minBubbleSize),
          color: widget
                  .bubbleColors?[random.nextInt(widget.bubbleColors!.length)] ??
              _getRandomColor(),
          opacity: widget.minOpacity +
              random.nextDouble() * (widget.maxOpacity - widget.minOpacity),
        );

        controller.reset();

        Future.delayed(Duration(milliseconds: random.nextInt(2000)), () {
          if (mounted) {
            _startBubbleAnimation(index);
          }
        });
      }
    });
  }

  Color _getRandomColor() {
    final random = Random();
    final colors = [
      Colors.blue,
      Colors.purple,
      Colors.pink,
      Colors.cyan,
      Colors.teal,
      Colors.indigo,
      Colors.deepPurple,
    ];
    return colors[random.nextInt(colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: BubblePainter(
              animations: _animations,
              bubbles: _bubbles,
              enableShimmer: widget.enableShimmer,
            ),
          ),
        ),
        widget.child,
      ],
    );
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
