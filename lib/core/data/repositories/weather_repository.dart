import 'dart:convert';

import 'package:tenis_app/core/data/models/api/weather_response.dart';
import 'package:tenis_app/core/data/services/weather_service.dart';

class WeatherRepository {
  final _service = WeatherService();

  Future<WeatherResponse> getRainPercent(
      {required void Function(dynamic) onError}) async {
    final result = await _service.getRainPercent(onError: onError);
    return WeatherResponse.fromJson(jsonDecode(result.data));
  }
}
