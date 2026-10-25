import 'package:flutter/material.dart';

class BoxDecorationHelper {
  static BoxDecoration buildMinesweeperDecoration(
      ToggleButtonsThemeData themeData,
      [bool reverse = false]) {
    final side1 = BorderSide(
      color: (reverse ? themeData.borderColor : themeData.color) ??
          Colors.transparent,
      width: 3.0,
    );
    final side2 = BorderSide(
      color: (reverse ? themeData.color : themeData.borderColor) ??
          Colors.transparent,
      width: 3.0,
    );
    return BoxDecoration(
      color: themeData.fillColor ?? Colors.transparent,
      border: Border(
        left: side1,
        top: side1,
        right: side2,
        bottom: side2,
      ),
    );
  }
}
