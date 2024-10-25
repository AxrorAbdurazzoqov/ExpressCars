import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:express_cars/src/core/common/car_model.dart';
import 'package:express_cars/src/core/utils/base_url.dart';

abstract class HomeDataSource {
  Future<List<CarModel>> getRentals();
}

class HomeDataSourceImpl extends HomeDataSource {
  final Dio _dio;

  HomeDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<CarModel>> getRentals() async {
    try {
      final Response response = await _dio.get('$baseUrl/rentals');

      if (response.statusCode != null && response.statusCode == 200) {
        return (jsonDecode(response.data)['data'] as List).map((mp) => CarModel.fromJson(mp)).toList();
      } else {
        throw Exception(response.statusMessage ?? "something went wrong");
      }
    } catch (e) {
      rethrow;
    }
  }
}
