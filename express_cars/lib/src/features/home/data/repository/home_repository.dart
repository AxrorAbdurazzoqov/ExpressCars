import 'package:express_cars/src/core/common/brand_model.dart';
import 'package:express_cars/src/core/common/car_info_model.dart';
import 'package:express_cars/src/core/either/either.dart';
import 'package:express_cars/src/features/home/data/data_source/home_data_source.dart';

abstract class HomeRepository {
  Future<Either<String, List<BrandModel>>> fetchBrandCars();
  Future<Either<String, List<CarInfoModel>>> fetchPopularCars();
  Future<Either<String, List<CarInfoModel>>> fetchAllCars();
}

class HomeRepositoryImpl extends HomeRepository {
  final HomeDataSource _dataSource;

  HomeRepositoryImpl({required HomeDataSource dataSource}) : _dataSource = dataSource;

  @override
  Future<Either<String, List<BrandModel>>> fetchBrandCars() async {
    try {
      final List<BrandModel> result = await _dataSource.fetchBrandCars();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<CarInfoModel>>> fetchPopularCars() async {
    try {
      final List<CarInfoModel> result = await _dataSource.fetchPopularCars();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<CarInfoModel>>> fetchAllCars() async {
    try {
      final List<CarInfoModel> result = await _dataSource.fetchAllCars();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
