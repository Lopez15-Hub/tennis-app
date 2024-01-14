import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenis_app/core/blocs/popup/popup_cubit.dart';
import 'package:tenis_app/core/blocs/reservations/reservations_bloc.dart';
import 'package:tenis_app/core/blocs/weather/weather_bloc.dart';
import 'package:tenis_app/core/data/models/reservation_model.dart';
import 'package:tenis_app/core/helpers/date_helpers.dart';
import 'package:tenis_app/core/helpers/string_helpers.dart';
import 'package:tenis_app/presentation/widgets/widgets/reservation_item/confirm_delete_widget.dart';
import 'package:tenis_app/presentation/widgets/views/create_reservation_form/weather_widget.dart';
import 'package:tenis_app/presentation/widgets/widgets/reservation_item/normal_text_widget.dart';
import 'package:tenis_app/presentation/widgets/widgets/reservation_item/normal_title_widget.dart';

class ReservationItem extends StatelessWidget {
  const ReservationItem({super.key, required this.reservation});

  final Reservation reservation;
  @override
  Widget build(BuildContext context) {
    final popupCubit = BlocProvider.of<PopupCubit>(context);
    final reservationsBloc = BlocProvider.of<ReservationsBloc>(context);
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(WeatherItemRequested(reservation.dateOfReservation!));

    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NormalTitle(text: "Cancha ${reservation.court}"),
                IconButton(
                  onPressed: () => popupCubit.show(
                      context,
                      ConfirmDelete(
                        reservationsBloc: reservationsBloc,
                        reservationId: reservation.id,
                      )),
                  icon: Icon(Icons.delete, color: Colors.red[800], size: 32),
                ),
              ],
            ),
            NormalText(text: "Reservado por: ${reservation.customer}"),
            NormalText(
                text:
                    "Fecha de reserva: ${split(formatDate(reservation.dateOfReservation!), " ")}"),
            const Padding(
              padding: EdgeInsets.all(10),
              child: WeatherWidget(
                  alignment: CrossAxisAlignment.start, labelSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

