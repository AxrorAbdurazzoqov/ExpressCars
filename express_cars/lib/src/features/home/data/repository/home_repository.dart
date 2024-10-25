import 'package:express_cars/src/core/common/car_model.dart';
import 'package:express_cars/src/core/either/either.dart';
import 'package:express_cars/src/features/home/data/data_source/home_data_source.dart';

abstract class HomeRepository {
  Future<Either<String, List<CarModel>>> getRentals();
}

class HomeRepositoryImpl extends HomeRepository {
  final HomeDataSource _dataSource;

  HomeRepositoryImpl({required HomeDataSource dataSource}) : _dataSource = dataSource;

  @override
  Future<Either<String, List<CarModel>>> getRentals() async {
    try {
      final List<CarModel> result = await _dataSource.getRentals();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
