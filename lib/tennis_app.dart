import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenis_app/core/blocs/form_values/form_values_cubit.dart';
import 'package:tenis_app/core/blocs/popup/popup_cubit.dart';
import 'package:tenis_app/core/blocs/reservations/reservations_bloc.dart';
import 'package:tenis_app/core/blocs/snackbar/snackbar_cubit.dart';
import 'package:tenis_app/core/blocs/weather/weather_bloc.dart';
import 'package:tenis_app/core/data/repositories/reservations_repository.dart';
import 'package:tenis_app/core/data/repositories/weather_repository.dart';
import 'package:tenis_app/presentation/views/reservations/reservations_view.dart';

class TennisApp extends StatelessWidget {
  const TennisApp({super.key});

  @override
  Widget build(BuildContext context) {
    final blocProviders = [
      BlocProvider(create: (context) => FormValuesCubit()),
      BlocProvider(create: (context) => PopupCubit()),
      BlocProvider(create: (context) => SnackbarCubit()),
      BlocProvider(
          create: (context) =>
              ReservationsBloc(repository: ReservationsRepository())),
      BlocProvider(
          create: (context) => WeatherBloc(repository: WeatherRepository())),
    ];
    return MultiBlocProvider(
      providers: blocProviders,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  Reservations(),
      ),
    );
  }
}
