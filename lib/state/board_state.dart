import 'package:flutter/foundation.dart';
import 'package:minesweeper_online/models/square.dart';
import 'package:minesweeper_online/services/square_service.dart';

class BoardState with ChangeNotifier {
  final SweeperService service;
  BoardState({@required this.service}) {
    _boardSquares = this.service.generateBoardSquares();
  }

  List<Square> _boardSquares;
  List<Square> get boardSquares => _boardSquares;

  setBoard(List<Square> newBoardSquares) {
    _boardSquares = newBoardSquares;
    notifyListeners();
  }

  resetBoard() {
    _boardSquares = service.generateBoardSquares();
    notifyListeners();
  }
}
