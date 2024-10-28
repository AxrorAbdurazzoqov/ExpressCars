import 'package:express_cars/src/core/common/car_info_model.dart';
import 'package:express_cars/src/core/either/either.dart';
import 'package:express_cars/src/core/usecase/usecase.dart';
import 'package:express_cars/src/features/home/data/repository/home_repository.dart';

class FetchBrandCarsUsecase extends UseCase<List<CarInfoModel>, String> {
  final HomeRepository _repository;

  FetchBrandCarsUsecase({required HomeRepository repository}) : _repository = repository;

  @override
  Future<Either<dynamic, List<CarInfoModel>>> call(String params) => _repository.fetchBrandCars(params);
}
