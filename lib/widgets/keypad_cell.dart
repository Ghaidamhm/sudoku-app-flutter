import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import '../models/sudoku_grid.dart';

class KeyPadCell extends StatelessWidget {
  KeyPadCell({@required this.numberValue}) : assert(numberValue >= 0);
  final int numberValue;

  @override
  Widget build(BuildContext context) {
    final bool isSelected =
        context.watch<SudokuGrid>().selectedNumber == numberValue;
    return GestureDetector(
      onTap: () {
        context.read<SudokuGrid>().updateSelectedNumber(numberValue);
      },
      child: Container(
        height: MediaQuery.of(context).size.width >= 800 ? 60 : 35,
        width: MediaQuery.of(context).size.width >= 800 ? 60 : 35,
        decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.transparent,
            border: Border.all(
                color: Colors.black,
                width: MediaQuery.of(context).size.width >= 800 ? 2 : 1),
            borderRadius: BorderRadius.circular(1.0)),
        child: Padding(
          padding: EdgeInsets.all(
              MediaQuery.of(context).size.width >= 800 ? 16.0 : 10.0),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: numberValue == 0
                ? Icon(
                    Entypo.eraser,
                    color: isSelected ? Colors.white : Colors.black,
                  )
                : Text(
//  the user will be able to has blank space
                    numberValue.toString(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
