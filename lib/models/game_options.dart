import 'package:flutter/widgets.dart';
import 'package:minesweeper_online/models/matrix_dimensions.dart';

class GameOptions {
  
  const GameOptions({ @required this.dimensions, @required  this.mines });
  
  final MatrixDimensions dimensions;
  final int mines;

}