import 'package:express_cars/src/features/detail/domain/usecase/fetch_car_by_id_usecase.dart';
import 'package:express_cars/src/features/detail/presentation/bloc/bloc/detail_event.dart';
import 'package:express_cars/src/features/detail/presentation/bloc/bloc/detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final FetchCarByIdUsecase fetchCarByIdUsecase;
  DetailBloc({required this.fetchCarByIdUsecase}) : super(DetailState(status: DetailStatus.initial)) {
    on<FetchCarByIdEvent>((event, emit) async {
      final result = await fetchCarByIdUsecase.call(event.id);
      if (result.isRight) {
        emit(DetailState(status: DetailStatus.success, model: result.right));
      } else {
        emit(DetailState(status: DetailStatus.failure, errorMessage: result.left));
      }
    });
    on<ChooseTariffEvent>((event, emit) {
      emit(state.copyWith(tariff: event.tariff));
    });
  }
}
