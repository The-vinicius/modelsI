import 'package:flutter/material.dart';
import 'package:models/app/interactor/entities/model_entity.dart';

final modelsState = ValueNotifier<List<ModelEntity>>([]);
final modelLoadingState = ValueNotifier<bool>(false);
