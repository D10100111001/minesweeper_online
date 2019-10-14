import 'package:flutter/foundation.dart';
import 'package:minesweeper_online/models/square.dart';

class BoardState with ChangeNotifier {
  List<Square> boardSquares;
}