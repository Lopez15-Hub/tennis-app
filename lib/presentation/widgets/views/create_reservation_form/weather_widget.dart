import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenis_app/core/blocs/weather/weather_bloc.dart';
import 'package:tenis_app/presentation/widgets/app/loading_indicator_widget.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget(
      {super.key,
      this.elevation = 0,
      this.labelSize,
     required this.alignment});
  final int elevation;
  final double? labelSize;
  final CrossAxisAlignment alignment;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
         Text(
          "Estado del clima",
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: labelSize),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherRetrievedFailed) {
                return Text(
                  state.reason,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 16),
                );
              }
              if (state is WeatherLoading) {
                return const LoadingIndicator();
              }
              if (state is WeatherRetrievedWithoutResults) {
                return const Text(
                  "No se encontraron datos",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16),
                );
              }
              if (state is WeatherItemRetrieved) {
                return ListTile(
                  leading: const Icon(
                    Icons.water_drop,
                    color: Colors.blue,
                  ),
                  title: const Text("Posibilidad de lluvia"),
                  trailing: Text(
                    state.weatherData.pop <= 0.0
                        ? "0%"
                        : "${state.weatherData.pop * 100}%",
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              }
              if (state is WeatherRetrieved) {
                return ListTile(
                  leading: const Icon(
                    Icons.water_drop,
                    color: Colors.blue,
                  ),
                  title: const Text("Posibilidad de lluvia"),
                  trailing: Text(
                    state.weatherData.pop <= 0.0
                        ? "0%"
                        : "${state.weatherData.pop * 100}%",
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              }
              return const Text(
                "Elije una fecha para ver el clima",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 14),
              );
            },
          ),
        ),
      ],
    );
  }
}
