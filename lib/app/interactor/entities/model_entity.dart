import 'dart:io';

import 'package:flutter/material.dart';

class ModelEntity extends ChangeNotifier {
  int id;
  File? image;
  String urlImage;
  String name;
  String instagram;
  String category;

  ModelEntity({
    this.image,
    required this.id,
    required this.urlImage,
    required this.name,
    required this.instagram,
    required this.category,
  });

  ModelEntity copyWith({
    int? id,
    File? image,
    String? urlImage,
    String? name,
    String? instagram,
    String? category,
  }) {
    return ModelEntity(
      image: image,
      id: id ?? this.id,
      urlImage: urlImage ?? this.urlImage,
      name: name ?? this.name,
      instagram: instagram ?? this.instagram,
      category: category ?? this.category,
    );
  }

  void updateImage(File image) {
    this.image = image;
    notifyListeners();
  }

  void clean() {
    name = '';
    instagram = '';
    image = null;

    notifyListeners();
  }

  static ModelEntity empyt() {
    return ModelEntity(
        id: 0, urlImage: '', name: '', instagram: '', category: 'atriz');
  }
}
