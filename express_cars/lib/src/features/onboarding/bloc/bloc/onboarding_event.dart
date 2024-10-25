import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();
}

class OnIndexChangedEvent extends OnboardingEvent {
  final int index;
  final VoidCallback onSuccess;

  const OnIndexChangedEvent({required this.index, required this.onSuccess});

  @override
  List<Object?> get props => [
        index
      ];
}