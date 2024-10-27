import 'package:express_cars/src/core/common/car_info_model.dart';
import 'package:express_cars/src/core/either/either.dart';
import 'package:express_cars/src/core/usecase/usecase.dart';
import 'package:express_cars/src/features/home/data/repository/home_repository.dart';

class FetchPopularCarsUsecase extends UseCase<List<CarInfoModel>, NoParams> {
  final HomeRepository _repository;

  FetchPopularCarsUsecase({required HomeRepository repository}) : _repository = repository;

  @override
  Future<Either<String, List<CarInfoModel>>> call(params) => _repository.fetchPopularCars();
}