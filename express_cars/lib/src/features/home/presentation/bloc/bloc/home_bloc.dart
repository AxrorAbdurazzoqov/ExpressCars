import 'package:express_cars/src/core/common/car_info_model.dart';
import 'package:express_cars/src/core/usecase/usecase.dart';
import 'package:express_cars/src/features/home/domain/usecase/fetch_all_cars_usecase.dart';
import 'package:express_cars/src/features/home/domain/usecase/fetch_brands_usecase.dart';
import 'package:express_cars/src/features/home/domain/usecase/fetch_popular_cars_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:express_cars/src/features/home/presentation/bloc/bloc/home_event.dart';
import 'package:express_cars/src/features/home/presentation/bloc/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchBrandsUsecase fetchBrandsUsecase;
  final FetchPopularCarsUsecase fetchPopularCarsUsecase;
  final FetchAllCarsUsecase fetchAllCarsUsecase;

  HomeBloc({required this.fetchBrandsUsecase, required this.fetchPopularCarsUsecase, required this.fetchAllCarsUsecase}) : super(HomeState(status: HomeStatus.initial)) {
    on<FetchAllDataEvent>((event, emit) async {
      emit(state.copyWith(status: HomeStatus.loading));

      final brandsData = await fetchBrandsUsecase.call(NoParams());
      final popularCarsData = await fetchPopularCarsUsecase.call(NoParams());

      if (brandsData.isRight && popularCarsData.isRight) {
        emit(state.copyWith(
          status: HomeStatus.success,
          brandsData: brandsData.right,
          popularCarsData: popularCarsData.right,
        ));
      } else {
        emit(
          state.copyWith(status: HomeStatus.failure, errorMessage: brandsData.left + popularCarsData.left),
        );
      }
    });

    on<FetchHomeScreenData>((event, emit) async {
      final result = await fetchAllCarsUsecase.call(NoParams());
      emit(HomeState(status: HomeStatus.loading));
      if (result.isRight) {
        print('Data came 3 ${result.right}');
        emit(state.copyWith(allCarsData: result.right, status: HomeStatus.success));
      } else {
        emit(state.copyWith(errorMessage: result.left, status: HomeStatus.failure));
      }
    });
    on<OnFilteringEvent>((event, emit) {
      final List<CarInfoModel> data = List.from(state.allCarsData ?? []);
      switch (event.filter) {
        case 'Recommended':
          add(FetchHomeScreenData());
          break;
        case 'New Models':
          data.sort((a, b) => b.year.compareTo(a.year));
          emit(state.copyWith(status: HomeStatus.success, allCarsData: data));
          break;
        default:
          emit(state.copyWith(allCarsData: data));
      }
    });

    on<OnCustomDetailFilterEvent>((event, emit) {
      List<CarInfoModel> filteredCars = List.from(state.allCarsData ?? []);

      filteredCars = filteredCars.where((car) => car.pricePerMonth >= event.rangeValues.start && car.pricePerMonth <= event.rangeValues.end).toList();

      if (event.filters.isNotEmpty) {
        filteredCars = filteredCars.where((car) => event.filters.contains(car.type)).toList();
      }

      for (String feature in event.features) {
        switch (feature) {
          case 'Air-conditioning':
            filteredCars = filteredCars.where((car) => car.features.airConditioner == true).toList();
            break;
          case 'Transmission':
            filteredCars = filteredCars.where((car) => car.features.transmission == feature).toList();
            break;
        }
      }

      emit(state.copyWith(allCarsData: filteredCars, status: HomeStatus.success));
    });
  }
}
