part of 'reservations_bloc.dart';

sealed class ReservationsState extends Equatable {}

final class ReservationsInitial extends ReservationsState {
  ReservationsInitial();

  @override
  List<Object?> get props => [];
}

final class SavingReservation extends ReservationsState {
  SavingReservation();

  @override
  List<Object?> get props => [];
}

final class ReservationLimitExceeded extends ReservationsState {
  final String message;
  ReservationLimitExceeded(this.message);

  @override
  List<Object?> get props => [message];
}

final class ReservationCreated extends ReservationsState {
  ReservationCreated();

  @override
  List<Object?> get props => [];
}

final class ReservationDeleted extends ReservationsState {
  ReservationDeleted();

  @override
  List<Object?> get props => [];
}

final class ReservationsEmpty extends ReservationsState {
  ReservationsEmpty();

  @override
  List<Object?> get props => [];
}

final class ReservationsRetrieved extends ReservationsState {
  final List<Reservation> reservations;
  ReservationsRetrieved(this.reservations);

  @override
  List<Object?> get props => [reservations];
}

final class ReservationsError extends ReservationsState {
  final String reason;
  ReservationsError(this.reason);

  @override
  List<Object?> get props => [reason];
}
