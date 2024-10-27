import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FetchAllDataEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

abstract class HomeEvent extends Equatable {}

class FetchHomeScreenData extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class OnFilteringEvent extends HomeEvent {
  final String filter;

  OnFilteringEvent({required this.filter});
  @override
  List<Object?> get props => [
        filter
      ];
}

class OnCustomDetailFilterEvent extends HomeEvent {
  final RangeValues rangeValues;
  final List<String> filters;
  final List<String> features;

  OnCustomDetailFilterEvent({required this.rangeValues, required this.filters, required this.features});

  @override
  List<Object?> get props => [
        rangeValues,
        filters,
        features,
      ];
}
