import 'dart:convert';

import 'package:express_cars_server/utils/data.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class CarsEndpoint {
  CarsEndpoint.init();
  static CarsEndpoint get instance => _instance;
  static final CarsEndpoint _instance = CarsEndpoint.init();

  void getAllCars({required Router api, required String endpoint}) {
    api.get(
      endpoint,
      (Request request) {
        try {
          final List<Map> data = cars;

          return Response.ok(
            jsonEncode(data),
          );
        } catch (e) {
          return Response.internalServerError(
            body: jsonEncode({
              "errorMessage": e.toString(),
            }),
          );
        }
      },
    );
  }

  void getBrand({required Router api, required String endpoint}) {
    api.get(
      endpoint,
      (Request request) {
        try {
          final List<Map> data = brands
              .map(
                (mp) => {
                  "name": mp['name'],
                  "image": mp['image'],
                  "avaible": cars.where((car) => car['brand'] == mp['name']).toList()
                },
              )
              .toList();

          return Response.ok(
            jsonEncode(data),
          );
        } catch (e) {
          return Response.internalServerError(
            body: jsonEncode({
              "errorMessage": e.toString(),
            }),
          );
        }
      },
    );
  }

  void getPopularCars({required Router api, required String endpoint}) {
    api.get(
      endpoint,
      (Request request) {
        try {
          List models = List.from(cars);
          models.sort((a, b) => a["reviews"].length.compareTo(b["reviews"].length));

          //! 40% of cars
          int count = (models.length * 0.4).ceil();

          models = models.getRange(0, count).toList();

          return Response.ok(
            jsonEncode(models),
          );
        } catch (e) {
          return Response.internalServerError(
            body: {
              "errorMessage": e.toString(),
            },
          );
        }
      },
    );
  }

  void getCarById({required Router api, required String endpoint}) {
    api.get(
      endpoint,
      (Request request, String id) {
        try {
          final Map result = cars.firstWhere((mp) => mp['car_id'] == id);

          return Response.ok(
            jsonEncode(result),
          );
        } catch (e) {
          return Response.internalServerError(
            body: jsonEncode({
              "errorMessage": e.toString(),
            }),
          );
        }
      },
    );
  }

  void getCarsByBrand({required Router api, required String endpoint}) {
    api.get(
      endpoint,
      (Request request, String brandName) {
        try {
          List models = cars.where((car) => car['brand'].toLowerCase() == brandName.toLowerCase()).toList();

          if (models.isEmpty) {
            return Response.notFound(
              {
                "errorMessage": "No cars for brand $brandName",
              },
            );
          }

          return Response.ok(
            jsonEncode(models),
          );
        } catch (e) {
          return Response.internalServerError(
            body: {
              "errorMessage": e.toString(),
            },
          );
        }
      },
    );
  }
}
