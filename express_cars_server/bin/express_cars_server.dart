import 'dart:io';
import 'package:express_cars_server/utils/base_url.dart';
import 'package:express_cars_server/express_cars_logic.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

Response _optionsHandler(Request request) => Response.ok('', headers: _corsHeaders);

final Map<String, String> _corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization',
};

Middleware _corsMiddleware() {
  return (Handler handler) {
    return (Request request) async {
      if (request.method == 'OPTIONS') return _optionsHandler(request);
      final Response response = await handler(request);
      return response.change(headers: _corsHeaders);
    };
  };
}

void main() async {
  // await HiveService.instance.cleanDB();
  // HiveService.instance.createBox();

  final router = expressCarsServerLogic();

  final handler = const Pipeline().addMiddleware(_corsMiddleware()).addHandler(router.call);

  HttpServer server = await io.serve(handler, baseUrl, 8000);

  print("Server has successfully launched server: http://${server.address.host}:${server.port}");
}
