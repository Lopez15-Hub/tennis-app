import 'package:tenis_app/core/data/adapters/model_adapter.dart';

abstract class RepositoryAdapter<Entity> {
  final ModelAdapter<Entity> model;
  RepositoryAdapter({required this.model});


}
