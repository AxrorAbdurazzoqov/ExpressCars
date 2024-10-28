import 'dart:convert';

import 'package:express_cars_server/utils/data.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class RentalsEndpoint {
  RentalsEndpoint.init();
  static RentalsEndpoint get instance => _instance;
  static final RentalsEndpoint _instance = RentalsEndpoint.init();

  void bookCarById({required Router api, required String endpoint}) {
    api.post(endpoint, (Request request, String carId) async {
      try {
        final carIndex = cars.indexWhere((car) => car['car_id'] == carId);
        if (carIndex == -1 && cars[carIndex]['available'] == false) {
          return Response.notFound(
            jsonEncode({
              'error': 'Car not found or already booked'
            }),
          );
        }

        cars[carIndex]['available'] = false;

        return Response.ok(
          jsonEncode({
            'message': 'Car booked successfully',
            'car': cars[carIndex]
          }),
        );
      } catch (e) {
        return Response.internalServerError(
          body: jsonEncode({
            'error': 'Failed to book car',
            'errorMessage': e.toString()
          }),
        );
      }
    });
  }
}
