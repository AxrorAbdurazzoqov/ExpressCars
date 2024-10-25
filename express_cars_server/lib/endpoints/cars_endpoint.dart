import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class CarsEndpoint {
  CarsEndpoint.init();
  static CarsEndpoint get instance => _instance;
  static final CarsEndpoint _instance = CarsEndpoint.init();

  void getBrands({required Router api, required String endpoint}) {
    return api.get(
      endpoint,
      (Request request) {
        try {
          final data = [
            {
              "name": "Tesla",
              "image": "https://upload.wikimedia.org/wikipedia/commons/e/e8/Tesla_logo.png",
              "cars": [
                {
                  "car_id": "1",
                  "type": "Electric",
                  "name": "Tesla",
                  "model": "Model S",
                  "year": 2023,
                  "available": true,
                  "price_per_day": 300,
                  "price_per_week": 1800,
                  "price_per_month": 6000,
                  "image_url": "https://www.pngarts.com/files/11/Tesla-Model-S-PNG-Photo.png",
                  "features": {
                    "seats": 5,
                    "engine": 1000,
                    "fuel_type": "Electric",
                    "air_conditioner": true,
                    "transmission": "Automatic",
                  }
                },
              ],
            },
            {
              "name": "Mercedes",
              "image": "https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/2048px-Mercedes-Logo.svg.png",
              "cars": [
                {
                  "car_id": "2",
                  "type": "Luxury",
                  "name": "Mercedes",
                  "model": "S-Class",
                  "year": 2022,
                  "available": true,
                  "price_per_day": 400,
                  "price_per_week": 2500,
                  "price_per_month": 9000,
                  "image_url": "https://lakecomoincar.com/wp-content/uploads/2021/07/Mercedes-Benz-S-Class-1.png",
                  "features": {
                    "seats": 5,
                    "engine": 3000,
                    "fuel_type": "Petrol",
                    "air_conditioner": true,
                    "transmission": "Automatic",
                  }
                }
              ]
            },
            {
              "name": "Ferrari",
              "image": "https://i.pinimg.com/originals/4c/ab/f1/4cabf11ca2754891d4d9d20326eca835.png",
              "cars": [
                {
                  "car_id": "3",
                  "type": "Sports",
                  "name": "Ferrari",
                  "model": "488 GTB",
                  "year": 2021,
                  "available": false,
                  "price_per_day": 1000,
                  "price_per_week": 6000,
                  "price_per_month": 20000,
                  "image_url": "https://i.pinimg.com/originals/53/25/72/532572dd9912c378cc31e048ff42cb04.png",
                  "features": {
                    "seats": 2,
                    "engine": 3900,
                    "fuel_type": "Petrol",
                    "air_conditioner": true,
                    "transmission": "Automatic",
                  }
                }
              ]
            },
            {
              "name": "Bugatti",
              "image": "https://cdn.freelogovectors.net/wp-content/uploads/2023/03/bugatti_logo-freelogovectors.net_.png",
              "cars": [
                {
                  "car_id": "4",
                  "type": "Hypercar",
                  "name": "Bugatti",
                  "model": "Chiron",
                  "year": 2022,
                  "available": true,
                  "price_per_day": 2000,
                  "price_per_week": 12000,
                  "price_per_month": 45000,
                  "image_url": "https://i.pinimg.com/originals/e9/34/ac/e934ac022c9ecf2dadf6954610176627.png",
                  "features": {
                    "seats": 2,
                    "engine": 8000,
                    "fuel_type": "Petrol",
                    "air_conditioner": true,
                    "transmission": "Automatic",
                  }
                }
              ]
            },
            {
              "name": "BMW",
              "image": "https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/BMW.svg/768px-BMW.svg.png",
              "cars": [
                {
                  "car_id": "5",
                  "type": "SUV",
                  "name": "BMW",
                  "model": "X5",
                  "year": 2023,
                  "available": true,
                  "price_per_day": 250,
                  "price_per_week": 1500,
                  "price_per_month": 5000,
                  "image_url": "https://purepng.com/public/uploads/large/purepng.com-bmw-x5-black-cararbmwvehicletransport-961524663165j4y4d.png",
                  "features": {
                    "seats": 5,
                    "engine": 3000,
                    "fuel_type": "Petrol",
                    "air_conditioner": true,
                    "transmission": "Automatic",
                  }
                }
              ]
            },
            {
              "name": "Lamborghini",
              "image": "https://logos-world.net/wp-content/uploads/2021/03/Lamborghini-Logo.png",
              "cars": [
                {
                  "car_id": "6",
                  "type": "Sports",
                  "name": "Lamborghini",
                  "model": "Huracan",
                  "year": 2022,
                  "available": true,
                  "price_per_day": 800,
                  "price_per_week": 5000,
                  "price_per_month": 18000,
                  "image_url": "https://i.pinimg.com/originals/fa/4d/2c/fa4d2c29bbc89d64407d1682adfbbe19.png",
                  "features": {
                    "seats": 2,
                    "engine": 5200,
                    "fuel_type": "Petrol",
                    "air_conditioner": true,
                    "transmission": "Automatic",
                  }
                }
              ]
            }
          ];
          return Response.ok(
            json.encode({
              "status": "success",
              "message": "The rentals data fetched successfully.",
              "data": data,
            }),
          );
        } catch (e) {
          print(e);
        }
      },
    );
  }
}
