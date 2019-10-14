import 'package:quiver/core.dart';
import 'package:flutter/cupertino.dart';

@immutable
class MatrixCell {
  final int row;
  final int column;
  const MatrixCell({@required this.row, @required this.column});

  bool operator ==(o) {
    return o is MatrixCell && (o.row == row && o.column == column);
  }

  int get hashCode => hash2(row.hashCode, column.hashCode);
}
