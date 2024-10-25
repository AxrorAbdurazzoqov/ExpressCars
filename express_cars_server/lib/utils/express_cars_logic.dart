import 'package:express_cars_server/endpoints/cars_endpoint.dart';
import 'package:shelf_router/shelf_router.dart';

Router expressCarsServerLogic() {
  final api = Router();

  //! Get brands - GET
  CarsEndpoint.instance.getBrands(api: api, endpoint: '/rentals');

  return api;
}
