import 'package:express_cars/src/core/common/car_model.dart';
import 'package:express_cars/src/core/either/either.dart';
import 'package:express_cars/src/core/usecase/usecase.dart';
import 'package:express_cars/src/features/home/data/repository/home_repository.dart';

class GetRentalsUsecase extends UseCase<List<CarModel>, NoParams> {
  final HomeRepository _repository;

  GetRentalsUsecase({required HomeRepository repository}) : _repository = repository;

  @override
  Future<Either<String, List<CarModel>>> call(params) => _repository.getRentals();
}
