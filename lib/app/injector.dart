import 'package:auto_injector/auto_injector.dart';
import 'package:models/app/data/repositories/supabase_model_repository.dart';
import 'package:models/app/data/services/filepicker_select_image_service.dart';
import 'package:models/app/data/services/supabase_upload_image_service.dart';
import 'package:models/app/interactor/repositories/model_repository.dart';
import 'package:models/app/interactor/services/select_image_service.dart';
import 'package:models/app/interactor/services/upload_image_service.dart';

final injector = AutoInjector();

void setupInjector() {
  injector.add<ModelRepository>(SupabaseModelRepository.new);
  injector.add<UploadImageService>(SupabaseUploadImageService.new);
  injector.add<SelectImageService>(FilePickerSelectImageService.new);
  injector.commit();
}
