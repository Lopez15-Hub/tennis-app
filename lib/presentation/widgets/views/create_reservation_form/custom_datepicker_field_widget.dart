import 'package:flutter/material.dart';
import 'package:tenis_app/core/blocs/form_values/form_values_cubit.dart';
import 'package:tenis_app/core/blocs/popup/popup_cubit.dart';
import 'package:tenis_app/core/blocs/reservations/reservations_bloc.dart';

import '../../../../core/blocs/weather/weather_bloc.dart';

class CustomDatePickerField extends StatelessWidget {
  const CustomDatePickerField(
      {super.key,
      required this.inputType,
      required this.validator,
      required this.label,
      this.inputValue = "",
      this.onChanged,
      this.hint = "",
      this.enabled = true,
      required this.weatherBloc,
      required this.popupCubit,
      required this.formValuesCubit,
      required this.reservationsBloc});
  final TextInputType inputType;
  final String label, hint;
  final String? Function(String?)? validator;

  final String inputValue;
  final void Function(String)? onChanged;
  final bool enabled;
  final WeatherBloc weatherBloc;
  final PopupCubit popupCubit;
  final FormValuesCubit formValuesCubit;
  final ReservationsBloc reservationsBloc;

  @override
  Widget build(BuildContext context) {
    handleTime() async {
      reservationsBloc.add(ReadReservationsRequested());
      final DateTime date = await popupCubit.show(
          context,
          DatePickerDialog(
              initialDate: DateTime.now(),
              cancelText: "Cancelar",
              confirmText: "Seleccionar",
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 40))));

      formValuesCubit.capture<String>(
          "previewDate", "${date.day}/${date.month}/${date.year}");
      formValuesCubit.capture<String>("dateOfReservation", date.toString());

      if (date.toString().isNotEmpty &&
          formValuesCubit.state["court"] != null) {
        reservationsBloc.add(
            CheckReservationAvailability(date, formValuesCubit.state["court"]));
        weatherBloc.add(WeatherRequested(date));
      }
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 16),
          ),
          TextFormField(
            controller: TextEditingController(text: inputValue),
            onTap: handleTime,
            onChanged: onChanged,
            enabled: enabled,
            readOnly: true,
            validator: validator,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green[600]!)),
                border: const OutlineInputBorder(),
                hintText: hint),
            keyboardType: inputType,
          ),
        ],
      ),
    );
  }
}
