import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double get paddingTop => MediaQuery.of(this).viewPadding.top;
  double get paddingBottom => MediaQuery.of(this).viewPadding.bottom;
}
