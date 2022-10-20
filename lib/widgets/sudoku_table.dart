import 'package:flutter/material.dart';
import '../models/board_square.dart';
import 'sudoku_cell.dart';
import 'package:provider/provider.dart';
import '../models/sudoku_grid.dart';

class SudokuTable extends StatelessWidget {
  static const _borderRadius = 10.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(_borderRadius),
        ),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(_borderRadius),
        ),
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: List.generate(
            9,
            (int rowNumber) => TableRow(
              children: List.generate(
                9,
                (int columnNumber) => ChangeNotifierProvider<BoardSquare>.value(
                  value: context.watch<SudokuGrid>().userBoard[rowNumber]
                      [columnNumber],
                  child: SudokuCell(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
