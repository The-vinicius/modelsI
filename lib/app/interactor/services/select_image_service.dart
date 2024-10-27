import 'dart:io';

abstract class SelectImageService {
  Future<File?> select();
}
