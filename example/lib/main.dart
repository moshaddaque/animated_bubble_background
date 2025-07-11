import 'package:flutter/material.dart';
import 'package:animated_bubble_background/animated_bubble_background.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Bubble Background Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const DemoScreen(),
    );
  }
}

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AnimatedBubbleBackground(
        bubbleCount: 20,
        bubbleColors: [
          Colors.blue,
          Colors.purple,
          Colors.pink,
          Colors.cyan,
          Colors.teal,
        ],
        minBubbleSize: 40.0,
        maxBubbleSize: 120.0,
        animationDuration: Duration(seconds: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.bubble_chart,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                'Animated Bubble Background',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Beautiful floating bubbles for your Flutter app',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
