import 'package:sqflite/sqflite.dart';
import 'package:tenis_app/core/data/adapters/model_adapter.dart';

registerModels(Database db) async => await ModelAdapter.registerTables(db, {
      "Reservations": {
        "id": "INTEGER PRIMARY KEY",
        "court": "TEXT",
        "dateOfReservation": "TEXT",
        "customer": "TEXT",
      },
    });
