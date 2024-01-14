import 'package:http/http.dart' as http;
import 'package:tenis_app/core/data/adapters/http_adapter.dart';
import 'package:tenis_app/core/data/models/http_response.dart';

class HttpService implements HttpAdapter {
  @override
  Future<HttpResponse<T>> get<T>(String url,
      {Map<String, String>? headers,
      void Function(dynamic data)? onError}) async {
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      return HttpResponse(response.body as T, 200);
    } catch (error) {
      if (onError != null) onError(error);

      throw Error();
    }
  }
}
