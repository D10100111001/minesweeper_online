import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  final int maxDigits;
  final int count;
  final Color color;
  final String label;
  const Counter({
    super.key,
    this.maxDigits = 3,
    required this.count,
    required this.label,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textStyle = TextStyle(
      color: color,
      fontSize: textTheme.bodyLarge?.fontSize,
      fontFamily: 'Minesweeper',
    );
    return Tooltip(
      message: this.label,
      child: SizedBox(
        width: 60.0,
        child: Center(
          child: Text(
            count.toString().padLeft(maxDigits, '0'),
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
