import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tenis_app/core/data/models/reservation_model.dart';
import 'package:tenis_app/core/data/repositories/reservations_repository.dart';

part 'reservations_event.dart';
part 'reservations_state.dart';

class ReservationsBloc extends Bloc<ReservationsEvent, ReservationsState> {
  final ReservationsRepository repository;
  ReservationsBloc({required this.repository}) : super(ReservationsInitial()) {
    on<CreateReservationRequested>((event, emit) async {
      emit(SavingReservation());
      try {
        final newReservation = Reservation(
          court: event.values["court"],
          customer: event.values["customer"],
          dateOfReservation: DateTime.parse(event.values["dateOfReservation"]),
        );
        await repository.model.create(newReservation);
        emit(ReservationCreated());
        add(ReadReservationsRequested());
      } catch (error) {
        debugPrint(
            "Ha ocurrido un error reservando la cancha. Intenta de nuevo más tarde.$error");
        emit(ReservationsError(
            "Ha ocurrido un error reservando la cancha. Intenta de nuevo más tarde.$error"));
      }
    });

    on<ReadReservationsRequested>((event, emit) async {
      try {
        final List<Reservation> reservations =
            await repository.model.findAndOrderBy("dateOfReservation");
        if (reservations.isEmpty) {
          emit(ReservationsEmpty());
        } else {
          emit(ReservationsRetrieved(reservations));
        }
      } catch (error) {
        emit(ReservationsError(
            "Ha ocurrido un error obteniendo tus reservas. Intenta de nuevo más tarde."));
      }
    });
    on<DeleteReservationRequested>((event, emit) async {
      try {
        await repository.model.deleteOne(event.reservationId);
        emit(ReservationDeleted());
        add(ReadReservationsRequested());
      } catch (error) {
        emit(ReservationsError(
            "Ha ocurrido un error eliminando la reserva. Intenta de nuevo más tarde."));
      }
    });
    on<CheckReservationAvailability>((event, emit) async {
      try {
        final int totalReservations = await repository.countByDateAndCourt(
            event.date.toString(), event.court);
        if (totalReservations == 3) {
          emit(ReservationLimitExceeded("No hay reservas para esta fecha."));
        } else {
          emit(ReservationsInitial());
        }
      } catch (error) {
        emit(ReservationsError(
            "Ha ocurrido un error eliminando la reserva. Intenta de nuevo más tarde."));
      }
    });
  }
}
