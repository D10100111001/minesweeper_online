import 'package:flutter/foundation.dart';

@immutable
class MatrixCell {
  final int row;
  final int column;
  const MatrixCell({required this.row, required this.column});

  @override
  bool operator ==(Object other) {
    return other is MatrixCell && (other.row == row && other.column == column);
  }

  @override
  int get hashCode => Object.hash(row, column);
}
