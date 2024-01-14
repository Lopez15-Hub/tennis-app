import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenis_app/core/blocs/reservations/reservations_bloc.dart';
import 'package:tenis_app/presentation/widgets/app/loading_indicator_widget.dart';
import 'package:tenis_app/presentation/widgets/views/reservations/reservation_item_widget.dart';

class ReservationsList extends StatelessWidget {
  const ReservationsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final reservationsBloc = BlocProvider.of<ReservationsBloc>(context);
    reservationsBloc.add(ReadReservationsRequested());

    return BlocBuilder<ReservationsBloc, ReservationsState>(
      builder: (context, state) {
        if (state is ReservationsError) {
          return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("No pudimos obtener tus reservas."),
                  ElevatedButton(
                      onPressed: () =>
                          reservationsBloc.add(ReadReservationsRequested()),
                      child: const Text("Reintentar"))
                ]),
          );
        }
        if (state is ReservationsEmpty) {
          return const Center(
            child: Text("No has realizado ninguna reserva aún"),
          );
        }
        if (state is ReservationsRetrieved) {
          return ListView.builder(
              itemCount: state.reservations.length,
              itemBuilder: (context, index) => ReservationItem(
                    reservation: state.reservations[index],
                  ));
        }
        return const LoadingIndicator();
      },
    );
  }
}
