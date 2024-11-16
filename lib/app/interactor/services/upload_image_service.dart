import 'dart:io';

abstract class UploadImageService {
  Future<String?> uplaod(File image);
}
