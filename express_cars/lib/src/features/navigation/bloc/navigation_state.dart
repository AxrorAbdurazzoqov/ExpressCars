import 'package:equatable/equatable.dart';
import 'package:express_cars/src/features/home/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';

class NavigationState extends Equatable {
  final int currentIndex;
  final List<Widget> screens = [
    const HomeScreen(),
    Container(color: Colors.teal),
    Container(color: Colors.blueAccent),
    Container(color: Colors.purpleAccent),
  ];

  NavigationState({this.currentIndex = 0});

  @override
  List<Object> get props => [
        currentIndex
      ];
}