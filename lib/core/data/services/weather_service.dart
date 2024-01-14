import 'package:tenis_app/core/data/adapters/rest_service_adapter.dart';
import 'package:tenis_app/core/data/models/http_response.dart';
import 'package:tenis_app/core/data/services/http_service.dart';

import '../../config/weather_api_config.dart';

class WeatherService extends RestServiceAdapter {
  WeatherService()
      : super(
            http: HttpService(),
            entryPoint: "https://api.openweathermap.org/data/2.5",
            apiKey: weatherApiKey);

  Future<HttpResponse<String>> getRainPercent({
    required void Function(dynamic data) onError,
  }) async {
    try {
      return await http.get(
        route("/forecast",
            query: {"q": "Neuquen,AR", "cnt": "40", "APPID": apiKey!}),
        onError: onError,
        headers: getDefaultHeaders(),
      );
    } catch (error) {
      onError(error.toString());
      throw Exception();
    }
  }
}
