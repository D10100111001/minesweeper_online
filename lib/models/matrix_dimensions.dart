class MatrixDimensions {
  final int rows;
  final int columns;
  const MatrixDimensions({this.rows, this.columns});

  int get total => rows * columns;
}
