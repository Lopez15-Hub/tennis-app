part of 'reservations_bloc.dart';

sealed class ReservationsEvent {}

class CreateReservationRequested extends ReservationsEvent {
  final Map<String, dynamic> values;
  CreateReservationRequested(this.values);
}

class ReadReservationsRequested extends ReservationsEvent {}

class CheckReservationAvailability extends ReservationsEvent {
  final DateTime date;
  final String court;
  CheckReservationAvailability(this.date, this.court);
}

class DeleteReservationRequested extends ReservationsEvent {
  final int reservationId;
  DeleteReservationRequested(this.reservationId);
}
