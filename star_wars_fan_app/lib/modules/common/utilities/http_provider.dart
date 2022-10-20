import 'package:http/http.dart' as http;
import 'http_enum.dart';

class SWHttpProvider {
  static Future<http.Response?> apiRequest(Method method, String path,
      {dynamic body}) async {
    body = (body == null) ? '' : body;
    print('API request $method $path $body');
    http.Response? response;
    final uri = "https://swapi.dev/api/" + path;
    try {
      switch (method) {
        case Method.GET:
          response = await http.get(Uri.parse(uri));
          break;
        case Method.POST:
          response = await await http.post(Uri.parse(uri));
          break;
        case Method.PATCH:
          response = await await http.patch(Uri.parse(uri));
          break;
        case Method.DELETE:
          response = await http.delete(Uri.parse(uri));
          break;
      }
    } catch (e) {
      print('Error occurred while performing API request $method $path: ' +
          e.toString());
    }
    print('API request $method $path returned: ' +
        response!.statusCode.toString() +
        ' ' +
        response.body.toString());
    return response;
  }
}
