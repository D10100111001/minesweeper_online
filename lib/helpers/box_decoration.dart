import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BoxDecorationHelper {
  static BoxDecoration buildMinesweeperDecoration(ToggleButtonsThemeData themeData,
      [bool reverse = false]) {
    final side1 = BorderSide(
      color: reverse ? themeData.borderColor : themeData.color,
      width: 3.0,
    );
    final side2 = BorderSide(
      color: reverse ? themeData.color : themeData.borderColor,
      width: 3.0,
    );
    return BoxDecoration(
      color: themeData.fillColor,
      border: Border(
        left: side1,
        top: side1,
        right: side2,
        bottom: side2,
      ),
    );
  }
}
