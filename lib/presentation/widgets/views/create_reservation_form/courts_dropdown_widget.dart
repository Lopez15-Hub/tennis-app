import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenis_app/core/blocs/form_values/form_values_cubit.dart';
import 'package:tenis_app/core/blocs/reservations/reservations_bloc.dart';

class CourtsDropdown extends StatelessWidget {
  const CourtsDropdown({super.key, this.validator});
  final String? Function(dynamic)? validator;

  @override
  Widget build(BuildContext context) {
    final formValuesCubit = BlocProvider.of<FormValuesCubit>(context);
    final reservationsBloc = BlocProvider.of<ReservationsBloc>(context);

    final List<DropdownMenuItem> options = [
      const DropdownMenuItem(value: "default", child: Text("Seleccione")),
      const DropdownMenuItem(value: "A", child: Text("Cancha A")),
      const DropdownMenuItem(value: "B", child: Text("Cancha B")),
      const DropdownMenuItem(value: "C", child: Text("Cancha C")),
    ];
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Cancha a reservar(*)",
            style: TextStyle(fontSize: 16),
          ),
          DropdownButtonFormField(
              value: "default",
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green[600]!)),
                border: const OutlineInputBorder(),
              ),
              onChanged: (court) {
                formValuesCubit.reset();
                formValuesCubit.capture<String>("court", court);
                reservationsBloc.add(ReadReservationsRequested());
              },
              validator: validator,
              items: options),
        ],
      ),
    );
  }
}
