# Animated Bubble Background

A beautiful animated bubble background widget for Flutter applications with customizable colors, sizes, and animation speeds. This package is created by Moshaddaque.

## Features

✨ **Smooth Animations**: Continuously floating bubbles with customizable speeds
🎨 **Customizable**: Colors, sizes, opacity, and bubble count
📱 **Performance Optimized**: Efficient rendering with custom painter
🌙 **Theme Support**: Works with both light and dark themes
🔧 **Easy to Use**: Simple integration with existing widgets

## Installation

Add this to your package's `pubspec.yaml` file:

### yaml
dependencies:
  animated_bubble_background: ^1.0.0

------------------------



## Usage
### Basic Implementation
dartimport 'package:animated_bubble_background/animated_bubble_background.dart';

AnimatedBubbleBackground(
  child: YourWidget(),
)

## Advanced Configuration
dartAnimatedBubbleBackground(
  bubbleCount: 20,
  bubbleColors: const [
    Colors.blue,
    Colors.purple,
    Colors.pink,
  ],
  minBubbleSize: 40.0,
  maxBubbleSize: 120.0,
  animationDuration: const Duration(seconds: 15),
  enableShimmer: true,
  minOpacity: 0.1,
  maxOpacity: 0.6,
  child: YourWidget(),
)


## Screenshot:
https://i.ibb.co/LXzmMKVq/ss.png