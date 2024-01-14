import 'package:tenis_app/core/data/adapters/model_adapter.dart';

class Reservation extends ModelAdapter<Reservation> {
  final String customer, court;
  final DateTime? dateOfReservation;
  final int id;
  Reservation(
      {this.dateOfReservation,
      this.court = "",
      this.customer = "",
      this.id = -1})
      : super('Reservations');

  @override
  Map<String, dynamic> toMap() => {
        "customer": customer,
        "court": court,
        "dateOfReservation": dateOfReservation.toString()
      };

  @override
  fromMap(Map<String, dynamic> data) => Reservation(
      customer: data["customer"],
      court: data["court"],
      dateOfReservation: DateTime.parse(data["dateOfReservation"]),
      id: data["id"]);
}
