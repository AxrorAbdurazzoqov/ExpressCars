import 'package:express_cars/src/core/usecase/usecase.dart';
import 'package:express_cars/src/features/home/domain/usecase/get_rentals_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:express_cars/src/features/home/presentation/bloc/bloc/home_event.dart';
import 'package:express_cars/src/features/home/presentation/bloc/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetRentalsUsecase getRentalsUsecase;
  HomeBloc({required this.getRentalsUsecase}) : super(HomeInitial()) {
    on<GetRentalsEvent>((event, emit) async {
      final result = await getRentalsUsecase.call(NoParams());
      if (result.isRight) {
        emit(HomeSuccess(data: result.right));
      } else {
        emit(HomeFailure(errorMessage: result.left));
      }
    });
  }
}
