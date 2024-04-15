import 'package:flutter/material.dart';

extension ContextExtension on BuildContext{
  double get safeAreaBottom => MediaQuery.of(this).padding.bottom;
  double get safeAreaTop => MediaQuery.of(this).padding.top;
  
}