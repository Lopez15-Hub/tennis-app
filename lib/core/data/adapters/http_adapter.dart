import 'package:tenis_app/core/data/models/http_response.dart';

abstract class HttpAdapter {
  Future<HttpResponse<T>> get<T>(
    String url, {
    Map<String, String>? headers,
    void Function(dynamic data)? onError,
  });
}
