import 'package:equatable/equatable.dart';
import 'package:express_cars/src/core/common/brand_model.dart';
import 'package:express_cars/src/core/common/car_info_model.dart';

class HomeState extends Equatable {
  final HomeStatus status;
  final String defaultImage = 'https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=';
  final String? errorMessage;
  final List<BrandModel>? brandsData;
  final List<CarInfoModel>? popularCarsData;
  final List<CarInfoModel>? allCarsData;
  final List<CarInfoModel>? brandCarsData;

  const HomeState({required this.status, this.errorMessage, this.brandsData, this.popularCarsData, this.allCarsData, this.brandCarsData});

  HomeState copyWith({List<BrandModel>? brandsData, List<CarInfoModel>? popularCarsData, HomeStatus? status, String? errorMessage, List<CarInfoModel>? allCarsData, List<CarInfoModel>? brandCarsData}) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      popularCarsData: popularCarsData ?? this.popularCarsData,
      brandsData: brandsData ?? this.brandsData,
      allCarsData: allCarsData ?? this.allCarsData,
      brandCarsData: brandCarsData ?? this.brandCarsData,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        brandsData,
        popularCarsData,
        allCarsData,
        brandCarsData,
        HomeStatus.initial,
        HomeStatus.loading,
        HomeStatus.success,
        HomeStatus.failure,
      ];
}

enum HomeStatus {
  initial,
  loading,
  success,
  failure,
}
