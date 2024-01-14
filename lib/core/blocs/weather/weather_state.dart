part of 'weather_bloc.dart';

sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherRetrievedWithoutResults extends WeatherState {}

final class WeatherRetrieved extends WeatherState {
  final ListElementResponse weatherData;
  WeatherRetrieved(this.weatherData);
}

final class WeatherItemRetrieved extends WeatherState {
  final ListElementResponse weatherData;
  WeatherItemRetrieved(this.weatherData);
}

final class WeatherRetrievedFailed extends WeatherState {
  final String reason;
  WeatherRetrievedFailed(this.reason);
}
