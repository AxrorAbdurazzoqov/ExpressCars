import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:express_cars/src/core/common/car_info_model.dart';
import 'package:express_cars/src/core/utils/base_url.dart';

abstract class DetailDataSource {
  Future<CarInfoModel> fetchCarInfo(String id);
  Future<void> bookCarById(String id);
}

class DetailDataSourceImpl extends DetailDataSource {
  final Dio _dio;

  DetailDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<CarInfoModel> fetchCarInfo(String id) async {
    try {
      final Response response = await _dio.get('$baseUrl/cars/$id');

      if (response.statusCode != null && response.statusCode == 200) {
        return CarInfoModel.fromJson(
          jsonDecode(response.data),
        );
      } else {
        throw Exception(response.statusMessage ?? "something went wrong");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> bookCarById(String id) async {
    try {
      final Response response = await _dio.post('$baseUrl/rentals/book/$id');

      if (response.statusCode != null && response.statusCode == 200) {
        return true;
      } else {
        print(response.statusCode);
        throw Exception(response.statusMessage ?? "something went wrong");
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
