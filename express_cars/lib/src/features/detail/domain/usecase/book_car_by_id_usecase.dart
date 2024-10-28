import 'package:express_cars/src/core/either/either.dart';
import 'package:express_cars/src/core/usecase/usecase.dart';
import 'package:express_cars/src/features/detail/data/repository/detail_repository.dart';

class BookCarByIdUsecase extends UseCase<void, String> {
  final DetailRepository _repository;

  BookCarByIdUsecase({required DetailRepository repository}) : _repository = repository;

  @override
  Future<Either<dynamic, void>> call(String params) => _repository.bookCarById(params);
}
