import 'package:models/app/core/extensions/value_notifier_extensions.dart';
import 'package:models/app/interactor/entities/model_entity.dart';
import 'package:models/app/interactor/repositories/model_repository.dart';
import 'package:models/app/interactor/states/model_states.dart';
import '../../injector.dart';

Future<void> fetchAllModel() async {
  modelLoadingState.setValue(true);
  final repository = injector.get<ModelRepository>();
  final models = await repository.getModels();
  modelsState.setValue(models);
  modelLoadingState.setValue(false);
}

Future<void> putModel(ModelEntity model) async {
  final repository = injector.get<ModelRepository>();
  await repository.putModels(model);
}

Future<void> deleteModel(ModelEntity model) async {
  final repository = injector.get<ModelRepository>();
  await repository.deleteModels(model);
  final models = modelsState.value.toList();
  models.removeWhere((m) => m.id == model.id);
  modelsState.setValue(models);
}
