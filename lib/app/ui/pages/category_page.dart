import 'package:flutter/material.dart';
import 'package:models/app/interactor/actions/model_actions.dart';
import 'package:models/app/interactor/entities/model_entity.dart';
import 'package:models/app/interactor/states/model_states.dart';
import 'package:routefly/routefly.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final ScrollController _scrollController = ScrollController();
  final String category = Routefly.query.arguments;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchByCategory(category, 0);
    });

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
    modelsState.value = [];
  }

  @override
  void didUpdateWidget(covariant CategoryPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      fetchByCategory(category, modelsState.value.length);
    }
  }

  void _deleteModel(ModelEntity model) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Deleta ${model.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('cancela'),
            ),
            TextButton(
                onPressed: () {
                  deleteModel(model);
                  Navigator.of(context).pop();
                },
                child: const Text('deleta'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category $category"),
      ),
      body: ValueListenableBuilder(
        valueListenable: modelsState,
        builder: (context, a, widget) {
          return modelLoadingState.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : modelsState.value.isEmpty
                  ? const Center(
                      child: Text('Bem-vindo'),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: modelsState.value.length +
                          (modelLoadingState.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < modelsState.value.length) {
                          final model = modelsState.value[index];
                          return InkWell(
                            onLongPress: () => _deleteModel(model),
                            child: Stack(
                              children: [
                                Card(
                                  child: Image.network(
                                    model.urlImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  child: Container(
                                    margin:
                                        const EdgeInsets.only(left: 5, top: 5),
                                    decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.horizontal(
                                            right: Radius.circular(10))),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      'Name: ${model.name}',
                                      softWrap: true,
                                      style: const TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        right: 5, bottom: 5),
                                    decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(10))),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      'instagram: @${model.instagram}',
                                      softWrap: true,
                                      style: const TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    );
        },
      ),
    );
  }
}
