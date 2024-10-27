import 'dart:io';

class ModelEntity {
  final String id;
  final File image;
  final String urlImage;
  final String name;
  final String instagram;
  final String category;

  ModelEntity(
    this.image, {
    required this.id,
    required this.urlImage,
    required this.name,
    required this.instagram,
    required this.category,
  });
}
