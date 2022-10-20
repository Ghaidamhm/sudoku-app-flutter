import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/solve_screen.dart';
import 'models/sudoku_grid.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SudokuGrid>(
      create: (context) => SudokuGrid.blank(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sudoku Solver',
        initialRoute: 'solve',
        routes: {
          'solve': (context) => SolveScreen(),
        },
      ),
    );
  }
}
