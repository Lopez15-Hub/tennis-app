part of 'weather_bloc.dart';

sealed class WeatherEvent {}

class WeatherRequested extends WeatherEvent {
  final DateTime datetime;
  WeatherRequested(this.datetime);
}

class WeatherItemRequested extends WeatherEvent {
  final DateTime datetime;
  WeatherItemRequested(this.datetime);
}
