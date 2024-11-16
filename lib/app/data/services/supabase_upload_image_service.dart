import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:models/app/interactor/services/upload_image_service.dart';
import 'package:models/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseUploadImageService implements UploadImageService {
  @override
  Future<String?> uplaod(File image) async {
    await supabase.storage.from('modelsi').upload(image.path, image,
        fileOptions: const FileOptions(cacheControl: '3600', upsert: false));
    final String publicUrl =
        supabase.storage.from('modelsi').getPublicUrl(image.path);
    return publicUrl;
  }
}
