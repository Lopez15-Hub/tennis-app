import 'package:tenis_app/core/data/models/api/list_element_response.dart';

class WeatherResponse {
  List<ListElementResponse> list;

  WeatherResponse({
    required this.list,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      WeatherResponse(
        list: List<ListElementResponse>.from(
            json["list"].map((x) => ListElementResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}
