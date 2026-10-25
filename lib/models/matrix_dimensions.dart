class MatrixDimensions {
  final int rows;
  final int columns;
  const MatrixDimensions({required this.rows, required this.columns});

  int get total => rows * columns;
}
