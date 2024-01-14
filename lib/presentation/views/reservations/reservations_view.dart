import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenis_app/core/blocs/reservations/reservations_bloc.dart';
import 'package:tenis_app/core/blocs/snackbar/snackbar_cubit.dart';

import 'package:tenis_app/presentation/widgets/app/appbar_widget.dart';
import 'package:tenis_app/presentation/views/create_reservation/create_reservation_view.dart';
import 'package:tenis_app/presentation/widgets/views/reservations/reservation_list_widget.dart';

class Reservations extends StatelessWidget {
  const Reservations({super.key});

  @override
  Widget build(BuildContext context) {
    final snackbarCubit = BlocProvider.of<SnackbarCubit>(context);
    

    return Scaffold(
      appBar: const CustomAppbarWidget(title: "Mis reservas"),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[300],
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateReservation()),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: BlocListener<ReservationsBloc, ReservationsState>(
        listener: (context, state) {
          if (state is ReservationDeleted) {
            snackbarCubit.success(context, "Reserva eliminada.");
          }
          if (state is ReservationCreated) {
            snackbarCubit.success(context, "Reserva creada.");
          }

          if (state is ReservationsError) {
            snackbarCubit.error(context, state.reason);
          }
        },
        child: const ReservationsList(),
      ),
    );
  }
}
