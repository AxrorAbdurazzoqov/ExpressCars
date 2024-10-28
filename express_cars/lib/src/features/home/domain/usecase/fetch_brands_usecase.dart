import 'package:express_cars/src/core/common/brand_model.dart';
import 'package:express_cars/src/core/either/either.dart';
import 'package:express_cars/src/core/usecase/usecase.dart';
import 'package:express_cars/src/features/home/data/repository/home_repository.dart';

class FetchBrandsUsecase extends UseCase<List<BrandModel>, NoParams> {
  final HomeRepository _repository;

  FetchBrandsUsecase({required HomeRepository repository}) : _repository = repository;

  @override
  Future<Either<String, List<BrandModel>>> call(params) => _repository.fetchBrands();
}
