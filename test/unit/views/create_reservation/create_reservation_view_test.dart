import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tenis_app/core/blocs/form_values/form_values_cubit.dart';
import 'package:tenis_app/core/blocs/popup/popup_cubit.dart';
import 'package:tenis_app/core/blocs/reservations/reservations_bloc.dart';
import 'package:tenis_app/core/blocs/weather/weather_bloc.dart';
import 'package:tenis_app/core/data/repositories/reservations_repository.dart';
import 'package:tenis_app/core/data/repositories/weather_repository.dart';
import 'package:tenis_app/core/helpers/data_validators_helpers.dart';
import 'package:tenis_app/presentation/widgets/views/create_reservation_form/courts_dropdown_widget.dart';
import 'package:tenis_app/presentation/widgets/views/create_reservation_form/custom_datepicker_field_widget.dart';
import 'package:tenis_app/presentation/widgets/views/create_reservation_form/custom_form_field_widget.dart';

import 'package:tenis_app/tennis_app.dart';

void main() {
  navigateToCreateReservationView(tester) async {
    await tester.pumpWidget(const TennisApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    final searchText = find.text("Reservar");
    expect(searchText, findsOneWidget);
  }

  group("0000_test_method_Navigator.push", () {
    testWidgets("Test if user can navigate to CreateReservation view",
        (WidgetTester tester) async => navigateToCreateReservationView(tester));
  });
  group("0001_test_form_fields", () {
    tryOptionsFromDropdown(tester) async {
      final courtsEntries = ["Cancha A", "Cancha B", "Cancha C"];

      for (final court in courtsEntries) {
        await tester.tap(find.byType(CourtsDropdown));
        await tester.pumpAndSettle();
        final dropdownItem = find.text(court).last;
        await tester.tap(dropdownItem);
        await tester.pumpAndSettle();
        expect(find.text(court), findsOneWidget);
      }
    }

    testWidgets("Test if i can select the court A in dropdown",
        (WidgetTester tester) async {
      await navigateToCreateReservationView(tester);
      await tester.pumpAndSettle();
      await tryOptionsFromDropdown(tester);
    });
    testWidgets("Test if i can write my name on input",
        (WidgetTester tester) async {
      const myName = "Ezequiel";
      await navigateToCreateReservationView(tester);
      await tester.pumpAndSettle();
      tester.enterText(find.byType(CustomFormField), myName);
    });
  });

  group("0002_test_date_picker_field", () {
    late FormValuesCubit formValuesCubit;
    late PopupCubit popupCubit;
    late ReservationsBloc reservationsBloc;
    late WeatherBloc weatherBloc;
    setUp(() {
      formValuesCubit = FormValuesCubit();
      popupCubit = PopupCubit();
      reservationsBloc = ReservationsBloc(repository: ReservationsRepository());
      weatherBloc = WeatherBloc(repository: WeatherRepository());
    });
    testWidgets("Test if datePicker is disabled because court is not selected.",
        (WidgetTester tester) async {
      await navigateToCreateReservationView(tester);
      expect(find.text('La cancha es requerida'), findsOneWidget);
    });
    testWidgets("Test if can i select the date of my reservation",
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomDatePickerField(
              formValuesCubit: formValuesCubit,
              popupCubit: popupCubit,
              reservationsBloc: reservationsBloc,
              weatherBloc: weatherBloc,
              enabled: formValuesCubit.state["court"] != "default",
              inputValue: formValuesCubit.state["previewDate"] ?? "",
              inputType: TextInputType.datetime,
              label: "Fecha de reserva(*)",
              validator: (date) => valueIsNotEmpty(date.toString(),
                  errorMessage: "Ingrese la fecha"),
              hint: "Pulse para seleccionar",
              onChanged: (date) => date,
            ),
          ),
        ),
      );
      await tester.tap(
          find.text(
            "Pulse para seleccionar",
          ),
          warnIfMissed: false);
      await tester.pumpAndSettle();
      await tester.tap(find.text('23'));
      final button = find.text('Seleccionar');
      await tester.tap(button);
      await tester.pumpAndSettle();
    });
  });
}
