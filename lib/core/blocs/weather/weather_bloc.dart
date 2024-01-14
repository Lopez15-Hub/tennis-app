import 'package:bloc/bloc.dart';
import 'package:tenis_app/core/data/models/api/list_element_response.dart';
import 'package:tenis_app/core/data/repositories/weather_repository.dart';
import 'package:tenis_app/core/helpers/string_helpers.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;

  WeatherBloc({required this.repository}) : super(WeatherInitial()) {
    on<WeatherRequested>((event, emit) async {
      emit(WeatherLoading());
      final result = await repository.getRainPercent(
        onError: (error) => WeatherRetrievedFailed(error),
      );
      try {
        final popOfDate = result.list.firstWhere((pronostic) =>
            split(pronostic.dtTxt, " ") == split(event.datetime, " "));
        emit(WeatherRetrieved(popOfDate));
      } catch (e) {
        emit(WeatherRetrievedWithoutResults());
      }
    });
    on<WeatherItemRequested>((event, emit) async {
      emit(WeatherLoading());
      final result = await repository.getRainPercent(
        onError: (error) => WeatherRetrievedFailed(error),
      );
      try {
        final popOfDate = result.list.firstWhere((pronostic) =>
            split(pronostic.dtTxt, " ") == split(event.datetime, " "));
        emit(WeatherItemRetrieved(popOfDate));
      } catch (e) {
        emit(WeatherRetrievedWithoutResults());
      }
    });
  }
}
