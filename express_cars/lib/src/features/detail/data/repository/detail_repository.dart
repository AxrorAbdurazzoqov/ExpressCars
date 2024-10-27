import 'package:express_cars/src/core/common/car_info_model.dart';
import 'package:express_cars/src/core/either/either.dart';
import 'package:express_cars/src/features/detail/data/data_source/detail_data_source.dart';

abstract class DetailRepository {
  Future<Either<String, CarInfoModel>> fetchCarInfo(String id);
}

class DetailRepositoryImpl extends DetailRepository {
  final DetailDataSource _dataSource;

  DetailRepositoryImpl({required DetailDataSource dataSource}) : _dataSource = dataSource;

  @override
  Future<Either<String, CarInfoModel>> fetchCarInfo(String id) async {
    try {
      final CarInfoModel result = await _dataSource.fetchCarInfo(id);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
