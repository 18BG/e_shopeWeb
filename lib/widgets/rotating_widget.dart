import 'package:flutter/material.dart';

class RotatingWidget extends StatefulWidget {
  @override
  _RotatingWidgetState createState() => _RotatingWidgetState();
}

class _RotatingWidgetState extends State<RotatingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * 3.141592653589793, // 2 * pi
          child: child,
        );
      },
      child: Icon(Icons.refresh, size: 48, color: Colors.green),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
