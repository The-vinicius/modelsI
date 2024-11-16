import 'package:models/app/interactor/entities/model_entity.dart';

abstract class ModelAdapter {
  static ModelEntity fromModel(Map<String, dynamic> map) {
    return ModelEntity(
      id: map['id'],
      urlImage: map['urlImage'],
      name: map['name'],
      instagram: map['instagram'],
      category: map['category'],
    );
  }

  static Map<String, dynamic> toMap(ModelEntity model) {
    return {
      'urlImage': model.urlImage,
      'name': model.name,
      'instagram': model.instagram,
      'category': model.category,
    };
  }
}
