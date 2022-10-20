import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/horizontal_layout.dart';
import '../widgets/vertical_layout.dart';

class SolveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // If the width is greater than 400px the phone can rotate
    // var _shortestSide = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return VerticalLayout();
            } else {
              return HorizontalLayout();
            }
          },
        ),
      ),
    );
  }
}
