import 'package:flutter/material.dart';
import 'package:tenis_app/core/blocs/reservations/reservations_bloc.dart';

class ConfirmDelete extends StatelessWidget {
  const ConfirmDelete({super.key, required this.reservationId,required this.reservationsBloc});
  final int reservationId;
  final ReservationsBloc reservationsBloc;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("¿Estás seguro?"),
      content: const Text(
          "Esta acción es irreversible y deberás volver a reservar la cancha."),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar")),
        TextButton(
            onPressed: () {
              reservationsBloc.add(DeleteReservationRequested(reservationId));
              Navigator.pop(context);
            },
            child: const Text("Eliminar")),
      ],
    );
  }
}
