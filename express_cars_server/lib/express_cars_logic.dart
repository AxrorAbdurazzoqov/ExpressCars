import 'package:express_cars_server/endpoints/cars_endpoint.dart';
import 'package:express_cars_server/endpoints/rentals_endpoint.dart';
import 'package:shelf_router/shelf_router.dart';

Router expressCarsServerLogic() {
  final api = Router();

  //! Get brands - GET
  CarsEndpoint.instance.getBrand(api: api, endpoint: '/brands');

  //! Get all cars - GET
  CarsEndpoint.instance.getAllCars(api: api, endpoint: '/cars');

  //! Get popular cars - GET
  CarsEndpoint.instance.getPopularCars(api: api, endpoint: '/popularCars');

  //! Get car by ID - GET
  CarsEndpoint.instance.getCarById(api: api, endpoint: '/cars/<carId>');

  //! Get cars by Brand - GET
  CarsEndpoint.instance.getCarsByBrand(api: api, endpoint: '/brand/<brandName>');

  //! Book car - POST
  RentalsEndpoint.instance.bookCarById(api: api, endpoint: '/rentals/book/<carId>');

  return api;
}
