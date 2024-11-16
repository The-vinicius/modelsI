import 'package:flutter/material.dart';
import 'package:models/app/interactor/actions/model_actions.dart';
import 'package:models/app/interactor/entities/model_entity.dart';

class ModelFormPage extends StatefulWidget {
  const ModelFormPage({super.key});

  @override
  State<ModelFormPage> createState() => _ModelFormPageState();
}

class _ModelFormPageState extends State<ModelFormPage> {
  final modeli = ModelEntity.empyt();
  final formKey = GlobalKey<FormState>();

  void _isValid() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    if (modeli.image == null) {
      return _showM();
    }
    await putModel(modeli);
  }

  void _showM() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Select a image")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Upload model'),
        ),
        floatingActionButton: ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                shadowColor: Colors.black,
                elevation: 5),
            onPressed: _isValid,
            child: const Text(
              'Save',
              style: TextStyle(fontSize: 18),
            )),
        body: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (name) {
                      modeli.name = name;
                    },
                    validator: (name) {
                      name = name ?? '';
                      if (name.isEmpty) {
                        return "required";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Name', hintText: 'name'),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        final image = await selectImage();
                        if (image != null) {
                          modeli.updateImage(image);
                        }
                      },
                      child: ListenableBuilder(
                          listenable: modeli,
                          builder: (context, widget) {
                            return Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                height: MediaQuery.of(context).size.height * .4,
                                width: MediaQuery.of(context).size.width * .8,
                                child: modeli.image != null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Image.file(
                                          modeli.image!,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      )
                                    : const Center(
                                        child: Text('Select Image'),
                                      ));
                          }),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (instagram) {
                      modeli.instagram = instagram;
                    },
                    validator: (instagram) {
                      instagram = instagram ?? '';
                      if (instagram.isEmpty) {
                        return "required";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Instagram'),
                  ),
                  const SizedBox(height: 20),
                  const Text('Category'),
                  FormField<String>(
                    validator: (value) {
                      if (modeli.category.isEmpty) {
                        return 'select category';
                      }
                      return null;
                    },
                    builder: (FormFieldState<String> state) {
                      return DropdownButton<String>(
                        hint: const Text('select category'),
                        value: modeli.category,
                        items: const [
                          DropdownMenuItem(
                            value: 'atriz',
                            child: Text('Atriz'),
                          ),
                          DropdownMenuItem(
                            value: 'youtube',
                            child: Text('youtube'),
                          ),
                          DropdownMenuItem(
                            value: 'streaming',
                            child: Text('streaming'),
                          ),
                          DropdownMenuItem(
                            value: 'singer',
                            child: Text('singer'),
                          ),
                        ],
                        onChanged: (String? category) {
                          final newCategory = category ?? 'atriz';
                          setState(() {
                            modeli.category = newCategory;
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
