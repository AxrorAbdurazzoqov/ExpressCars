import 'package:express_cars/src/core/common/car_info_model.dart';
import 'package:express_cars/src/core/either/either.dart';
import 'package:express_cars/src/core/usecase/usecase.dart';
import 'package:express_cars/src/features/detail/data/repository/detail_repository.dart';

class FetchCarByIdUsecase extends UseCase<CarInfoModel, String> {
  final DetailRepository _repository;

  FetchCarByIdUsecase({required DetailRepository repository}) : _repository = repository;

  @override
  Future<Either<dynamic, CarInfoModel>> call(String params) async => await _repository.fetchCarInfo(params);
}
