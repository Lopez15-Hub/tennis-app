import 'package:flutter/material.dart';
import 'package:tenis_app/core/data/services/sqlite_service.dart';
import 'package:tenis_app/tennis_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqliteService.instance.init(databaseName: "tennis.db");
  if (SqliteService.instance.db != null) runApp(const TennisApp());
}
