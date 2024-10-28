import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class DetailEvent extends Equatable {
  const DetailEvent();
}

class FetchCarByIdEvent extends DetailEvent {
  final String id;

  const FetchCarByIdEvent({required this.id});
  @override
  List<Object?> get props => [
        id
      ];
}

class ChooseTariffEvent extends DetailEvent {
  final String tariff;

  const ChooseTariffEvent({required this.tariff});

  @override
  List<Object?> get props => [
        tariff
      ];
}

class ChangeLocationEvent extends DetailEvent {
  final String? location;

  const ChangeLocationEvent({required this.location});

  @override
  List<Object?> get props => [
        location
      ];
}

class BookCarById extends DetailEvent {
  final String id;
  final VoidCallback onSuccess;
  final VoidCallback onFailure;

  const BookCarById({
    required this.id,
    required this.onSuccess,
    required this.onFailure,
  });

  @override
  List<Object?> get props => [];
}
