import 'package:flutter/material.dart';
import 'package:models/app/interactor/actions/model_actions.dart';
import 'package:models/app/interactor/entities/model_entity.dart';
import 'package:models/app/interactor/states/model_states.dart';
import 'package:models/main.dart';

final activeSession = supabase.auth.currentSession;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    if (activeSession == null) {
      Navigator.pushNamed(context, '/auth');
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchAllModel();
    });
    modelsState.addListener(_listen);
  }

  void _listen() {
    setState(() {});
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
              child: Text('cancela'),
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
    final modelsi = modelsState.value;
    Widget body = Container();
    if (modelLoadingState.value) {
      body = const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      body = RefreshIndicator(
        onRefresh: fetchAllModel,
        child: modelsi.isEmpty
            ? const Center(
                child: Text('Bem-vindo'),
              )
            : ListView.builder(
                itemCount: modelsi.length,
                itemBuilder: (context, index) {
                  final model = modelsi[index];
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
                            margin: const EdgeInsets.only(left: 5, top: 5),
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
                            margin: const EdgeInsets.only(right: 5, bottom: 5),
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
                },
              ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/upload');
                },
                icon: const Icon(Icons.upload))
          ],
        ),
        body: body);
  }
}
