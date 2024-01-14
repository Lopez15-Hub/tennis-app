import 'package:tenis_app/core/data/adapters/http_adapter.dart';

class RestServiceAdapter {
  final String entryPoint;
  final HttpAdapter http;
  final String? apiKey;
  RestServiceAdapter(
      {required this.entryPoint, required this.http, this.apiKey});
  getDefaultHeaders() => {
        "Content-type": "application/json",
      };
  route(String route, {Map<String, String>? query}) {
    final queryString = query != null
        ? query.entries.map((entry) => '${entry.key}=${entry.value}').join('&')
        : '';
    return "$entryPoint/$route?$queryString";
  }
}
