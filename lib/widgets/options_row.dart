import 'package:flutter/material.dart';
import '../models/sudoku_grid.dart';
import 'secondary_button.dart';
import 'package:provider/provider.dart';

class OptionsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SecondaryButton(
            onTap: () => context.read<SudokuGrid>().resetBoard(),
            label: 'Reset',
          ),
        ),
        SizedBox(
          width: 8.0,
        ),
      ],
    );
  }
}
