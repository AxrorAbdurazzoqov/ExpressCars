import 'package:flutter/material.dart';

extension MediaquerySize on BuildContext {
  double getHeight(double size) => MediaQuery.of(this).size.height * size;
  double getWidth(double size) => MediaQuery.of(this).size.width * size;
}
