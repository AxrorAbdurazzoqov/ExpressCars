// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:express_cars/src/core/common/car_info_model.dart';

class DetailState extends Equatable {
  final DetailStatus status;
  final String? errorMessage;
  final CarInfoModel? model;
  final String? tariff;
  final String? location;

  const DetailState({required this.status, this.errorMessage, this.model, this.tariff, this.location});

  DetailState copyWith({
    DetailStatus? status,
    String? errorMessage,
    CarInfoModel? model,
    String? tariff,
    String? location,
  }) {
    return DetailState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      model: model ?? this.model,
      tariff: tariff ?? this.tariff,
      location: location ?? this.location,
    );
  }

  @override
  List<Object?> get props => [
        status,
        model,
        location,
        errorPropertyTextConfiguration,
        tariff,
      ];
}

enum DetailStatus {
  initial,
  loading,
  success,
  failure,
}
