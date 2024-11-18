import 'package:models/app/data/repositories/adapters/model_adapter.dart';
import 'package:models/app/injector.dart';
import 'package:models/app/interactor/entities/model_entity.dart';
import 'package:models/app/interactor/repositories/model_repository.dart';
import 'package:models/app/interactor/services/upload_image_service.dart';
import 'package:models/main.dart';

class SupabaseModelRepository implements ModelRepository {
  @override
  Future<ModelEntity> deleteModels(ModelEntity model) async {
    await supabase.from('modelsi').delete().eq('id', model.id);
    final path = model.urlImage.split('/').last;
    await supabase.storage.from('modelsi').remove([path]);
    return model;
  }

  @override
  Future<List<ModelEntity>> getModels() async {
    final modelsi = await supabase.from('modelsi').select().range(0, 10);
    return modelsi.map((e) => ModelAdapter.fromModel(e)).toList();
  }

  @override
  Future<ModelEntity> putModels(ModelEntity model) async {
    final repository = injector.get<UploadImageService>();
    final url = await repository.uplaod(model.image!);
    model = model.copyWith(urlImage: url);
    await supabase.from('modelsi').insert(ModelAdapter.toMap(model));

    return model;
  }

  @override
  Future<List<ModelEntity>> getModelsByCategory(
      String category, int start, int end) async {
    final modelsi = await supabase
        .from('modelsi')
        .select()
        .eq('category', category)
        .range(start, end);
    return modelsi.map((e) => ModelAdapter.fromModel(e)).toList();
  }
}
