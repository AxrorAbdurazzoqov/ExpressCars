import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:express_cars/src/core/common/brand_model.dart';
import 'package:express_cars/src/core/common/car_info_model.dart';
import 'package:express_cars/src/core/utils/base_url.dart';

abstract class HomeDataSource {
  Future<List<BrandModel>> fetchBrandCars();
  Future<List<CarInfoModel>> fetchPopularCars();
  Future<List<CarInfoModel>> fetchAllCars();
}

class HomeDataSourceImpl extends HomeDataSource {
  final Dio _dio;

  HomeDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<BrandModel>> fetchBrandCars() async {
    try {
      final Response response = await _dio.get('$baseUrl/brands');

      if (response.statusCode != null && response.statusCode == 200) {
        return (jsonDecode(response.data) as List).map((mp) => BrandModel.fromJson(mp)).toList();
      } else {
        throw Exception(response.statusMessage ?? "something went wrong");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CarInfoModel>> fetchPopularCars() async {
    try {
      final Response response = await _dio.get('$baseUrl/popularCars');

      if (response.statusCode != null && response.statusCode == 200) {
        return (jsonDecode(response.data) as List).map((mp) => CarInfoModel.fromJson(mp)).toList();
      } else {
        throw Exception(response.statusMessage ?? "something went wrong");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CarInfoModel>> fetchAllCars() async {
    try {
      final Response response = await _dio.get('$baseUrl/cars');

      if (response.statusCode != null && response.statusCode == 200) {
        return (jsonDecode(response.data) as List).map((mp) => CarInfoModel.fromJson(mp)).toList();
      } else {
        throw Exception(response.statusMessage ?? "something went wrong");
      }
    } catch (e) {
      rethrow;
    }
  }
}
