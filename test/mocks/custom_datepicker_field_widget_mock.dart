import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenis_app/core/blocs/form_values/form_values_cubit.dart';
import 'package:tenis_app/core/blocs/reservations/reservations_bloc.dart';

class CustomDatePickerFieldMock extends StatelessWidget {
  const CustomDatePickerFieldMock(
      {super.key,
      required this.inputType,
      required this.validator,
      required this.label,
      this.inputValue = "",
      this.onChanged,
      this.hint = "",
      this.enabled = true});
  final TextInputType inputType;
  final String label, hint;
  final String? Function(String?)? validator;

  final String inputValue;
  final void Function(String)? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final formValuesCubit = BlocProvider.of<FormValuesCubit>(context);
    final reservationsBloc = BlocProvider.of<ReservationsBloc>(context);
    handleTime() async {
      reservationsBloc.add(ReadReservationsRequested());
      final DateTime date = await showDialog(
          context: context,
          builder: (builder) => DatePickerDialog(
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
