import 'package:models/app/interactor/entities/model_entity.dart';

abstract class ModelRepository {
  Future<List<ModelEntity>> getModels();
  Future<List<ModelEntity>> getModelsByCategory(
      String category, int start, int end);
  Future<ModelEntity> putModels(ModelEntity model);
  Future<ModelEntity> deleteModels(ModelEntity model);
}
