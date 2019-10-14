import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper_online/models/game_options.dart';
import 'package:minesweeper_online/models/key_value_pair.dart';
import 'package:minesweeper_online/models/matrix_cell.dart';
import 'package:minesweeper_online/models/matrix_dimensions.dart';
import 'package:minesweeper_online/models/square.dart';
import 'package:minesweeper_online/services/square_service.dart';

void main() {
  group('Sweeper Service Logic Test', () {
    SweeperService service = SweeperService(
      options: const GameOptions(
        dimensions: const MatrixDimensions(
          rows: 9,
          columns: 9,
        ),
        mines: 10,
      ),
    );
    List<Square> boardSquares = service.generateBoardSquares();
    test('cell to index conversion is accurate', () {
      final cells = [
        const MatrixCell(row: 3, column: 4),
        const MatrixCell(row: 1, column: 1),
        const MatrixCell(row: 9, column: 9),
        const MatrixCell(row: 5, column: 9),
      ];
      cells.forEach((cell) {
        final index = service.coordinateToIndex(cell);
        expect(
            index,
            ((service.options.dimensions.columns * (cell.row - 1)) +
                    cell.column) -
                1);
        final square = boardSquares.elementAt(index);
        expect(square.cell, cell);
      });
    });

    test('index to cell conversion is accurate', () {
      final indexMap = [
        KeyValuePair(
          key: service.options.dimensions.columns * 0,
          value: const MatrixCell(row: 1, column: 1),
        ),
        KeyValuePair(
          key: service.options.dimensions.columns * 2,
          value: const MatrixCell(row: 3, column: 1),
        ),
        KeyValuePair(
          key: service.options.dimensions.rows * 0,
          value: const MatrixCell(row: 1, column: 1),
        ),
        KeyValuePair(
          key: (service.options.dimensions.rows * 1) + 5,
          value: const MatrixCell(row: 2, column: 6),
        ),
      ];
      indexMap.forEach((kvp) {
        final cell = SweeperService.indexToCoordinates(
            kvp.key,
            service.options.dimensions.rows,
            service.options.dimensions.columns);
        expect(cell, kvp.value);
      });
    });
  });
}
