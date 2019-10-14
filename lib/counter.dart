import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Counter extends StatelessWidget {
  final int maxDigits;
  final int count;
  final Color color;
  final String label;
  const Counter(
      {Key key,
      this.maxDigits = 3,
      @required this.count,
      @required this.label,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textStyle = this.color != null
        ? TextStyle(color: color, fontSize: textTheme.body2.fontSize)
        : textTheme.body2;
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
