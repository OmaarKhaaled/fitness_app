import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _dot(double delay) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double value = (_controller.value - delay);
        value = value < 0 ? value + 1 : value;
        final scale = 0.5 + (value * 0.5);

        return Transform.scale(
          scale: scale.clamp(0.5, 1.0),
          child: const CircleAvatar(radius: 4, backgroundColor: Colors.white),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _dot(0.0),
        const SizedBox(width: 4),
        _dot(0.2),
        const SizedBox(width: 4),
        _dot(0.4),
      ],
    );
  }
}
