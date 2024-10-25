import 'package:equatable/equatable.dart';
import 'package:express_cars/src/core/common/car_model.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<CarModel> data;

  const HomeSuccess({required this.data});
}

final class HomeFailure extends HomeState {
  final String errorMessage;

  const HomeFailure({required this.errorMessage});
}
