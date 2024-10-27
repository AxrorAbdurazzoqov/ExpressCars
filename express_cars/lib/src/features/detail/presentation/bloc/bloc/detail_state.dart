// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:express_cars/src/core/common/car_info_model.dart';

class DetailState extends Equatable {
  final DetailStatus status;
  final String? errorMessage;
  final CarInfoModel? model;
  final String? tariff;

  const DetailState({required this.status, this.errorMessage, this.model, this.tariff});

  DetailState copyWith({
    DetailStatus? status,
    String? errorMessage,
    CarInfoModel? model,
    String? tariff,
  }) {
    return DetailState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      model: model ?? this.model,
      tariff: tariff ?? this.tariff,
    );
  }

  @override
  List<Object?> get props => [
        status,
        model,
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
