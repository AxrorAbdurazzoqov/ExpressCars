import 'package:equatable/equatable.dart';

sealed class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object?> get props => [];
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
