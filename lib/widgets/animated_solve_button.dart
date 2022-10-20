import 'package:flutter/material.dart';
import '../constants/enums.dart';
import '../models/sudoku_grid.dart';
import 'package:provider/provider.dart';
import 'custom_slider_thumb_rect.dart';

class AnimatedSolveButton extends StatefulWidget {
  @override
  _AnimatedSolveButtonState createState() => _AnimatedSolveButtonState();
}

class _AnimatedSolveButtonState extends State<AnimatedSolveButton>
    with TickerProviderStateMixin {

  final double _threshold = 95;
  final double _height = 50;

  double _currentSliderValue;
  String _sliderText;
  bool _animationHasPlayed = false;

  // Animations
  Animation<double> _sliderThumbAnimation;
  AnimationController _sliderThumbController;
  Animation<double> _loadingAnimation;
  AnimationController _loadingController;

  @override
  void initState() {
    super.initState();
    // Initialise slider variables
    _currentSliderValue = 0;
    _sliderText = '    Slide to solve >>>';

    // Initialise slider thumb 
    _sliderThumbController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _sliderThumbAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: _sliderThumbController,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn));
    _sliderThumbController.addListener(() {
      setState(() {});
    });

    // Initialise loading text 
    _loadingController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _loadingAnimation = Tween(begin: 3.0, end: 8.0).animate(CurvedAnimation(
        parent: _loadingController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut));
    _loadingController.addListener(() {
      setState(() {});
    });
    _loadingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _loadingController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _loadingController.forward();
      }
    });

    // Initialise background slider 
  }

  @override
  void dispose() {
    super.dispose();
    _sliderThumbController.dispose();
    _loadingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<SudokuGrid>().solveScreenStates ==
            SolveScreenStates.Idle &&
        context.watch<SudokuGrid>().boardErrors == BoardErrors.None) {
      if (_animationHasPlayed == true) {
        _sliderThumbController.reverse();
        _animationHasPlayed = false;
        _loadingController.reset();
      }
      setState(() {
        _sliderText = '    Slide to solve >>>';
      });
    }

    if (context.watch<SudokuGrid>().solveScreenStates ==
        SolveScreenStates.Solved) {
      setState(() {
        _sliderText = 'SOLVED!';
      });
      _loadingController.reset();
    }

    if (context.watch<SudokuGrid>().boardErrors == BoardErrors.Duplicate) {
      setState(() {
        _sliderText = 'Invalid Board - Duplicate Number';
      });
      _loadingController.reset();
    }

    return Container(
      height: _height,
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 1),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 2,
                ),
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
          Center(
            child: context.watch<SudokuGrid>().solveScreenStates ==
                    SolveScreenStates.Loading
                ? SizedBox(
                    width: 30,
                    height: 30,
                    child: Theme(
                        data: Theme.of(context)
                            .copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color.fromARGB(255, 0, 2, 4))),
                        child: CircularProgressIndicator()),
                  )
                : Text(
                    _sliderText,
                    style: TextStyle(
                    
                    ),
                  ),
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: Colors.transparent,
              inactiveTrackColor: Colors.transparent,
              overlayColor: Colors.transparent,
              thumbShape: CustomSliderThumbRect(
                thumbRadius: 20,
                thumbHeight: (_height - 8) * _sliderThumbAnimation.value,
                min: 0,
                max: 100,
              ),
            ),
            child: Slider(
              value: _currentSliderValue,
              min: 0,
              max: 100,
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
              onChangeEnd: (double value) async {
                if (value > _threshold) {
                  setState(() {
                    _currentSliderValue = 100;
                  });
                  _sliderThumbController.forward();

                  await Future.delayed(_sliderThumbController.duration);

                  // Reset
                  _currentSliderValue = 0;

                  // Call the function to solve
                  context
                      .read<SudokuGrid>()
                      .solveButtonPress(context.read<SudokuGrid>().userBoard);
                }
                if (value <= _threshold) {
                  setState(() {
                    _currentSliderValue = 0;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
