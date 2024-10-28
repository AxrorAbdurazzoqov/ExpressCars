import 'package:equatable/equatable.dart';
import 'package:express_cars/src/features/favourite/screen/favourite_screen.dart';
import 'package:express_cars/src/features/home/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';

class NavigationState extends Equatable {
  final int currentIndex;
  final List<Widget> screens = [
    const HomeScreen(),
    const FavouriteScreen(),
    Container(color: Colors.teal),
    Container(color: Colors.blueAccent),
  ];

  NavigationState({this.currentIndex = 0});

  @override
  List<Object> get props => [
        currentIndex
      ];
}