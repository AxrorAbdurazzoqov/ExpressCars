import 'package:flutter/material.dart';

class AppColors {
  static final AppColors _instance = AppColors.init();
  static AppColors get instance => _instance;
  AppColors.init();

  final Color white = const Color(0xffFFFFFF);
  final Color grey = const Color(0xffADADAD);
  final Color red = const Color(0xffFF0000);
  final Color blue = const Color(0xff288CE9);
  final Color black = const Color(0xff181B0E);
  final Color green = Colors.green;
  final Color greenAccent = const Color(0xffC3E54B);
  final Color lightGreenAccent = const Color(0xffC3E54B);
  final Color amber = Colors.amber;
}
