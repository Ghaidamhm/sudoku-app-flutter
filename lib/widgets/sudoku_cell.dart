import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/enums.dart';
import '../models/board_square.dart';
import '../models/sudoku_grid.dart';

class SudokuCell extends StatelessWidget {
  String getCellValue(int cellValue) {
    if (cellValue == 0) {
      return '';
    } else {
      return cellValue.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context
            .read<BoardSquare>()
            .updateValue(context.read<SudokuGrid>().selectedNumber);
        context.read<SudokuGrid>().boardErrors = BoardErrors.None;
        context.read<SudokuGrid>().solveScreenStates = SolveScreenStates.Idle;
      },
      child: AspectRatio(
        aspectRatio: 1.05,
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              right: BorderSide(
                width: (context.watch<BoardSquare>().position.y == 2 ||
                        context.watch<BoardSquare>().position.y == 5)
                    ? 1.5
                    : 0.5,
                color: Colors.black,
              ),
              bottom: BorderSide(
                width: (context.watch<BoardSquare>().position.x == 2 ||
                        context.watch<BoardSquare>().position.x == 5)
                    ? 1.5
                    : 0.5,
                color: Colors.black,
              ),
            ),
          ),
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Center(
              child: Text(
                getCellValue(context.watch<BoardSquare>().value),
                style: TextStyle(
                    // fontSize: 18,
                    color: context.watch<BoardSquare>().hasError
                        ? Colors.red
                        : Colors.black,
                    fontWeight: context.watch<BoardSquare>().userInputted
                        ? FontWeight.w900
                        : FontWeight.normal),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
