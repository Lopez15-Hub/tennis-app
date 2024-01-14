import 'package:tenis_app/core/data/adapters/repository_adapter.dart';
import 'package:tenis_app/core/data/models/reservation_model.dart';

class ReservationsRepository extends RepositoryAdapter<Reservation> {
  ReservationsRepository() : super(model: Reservation());
  Future<int> countByDateAndCourt(String date, String court) async {
    final results = await model.count(
        where: "dateOfReservation = ? AND court = ? ",
        whereArgs: [date, court]);
    return results ?? 0;
  }
}
