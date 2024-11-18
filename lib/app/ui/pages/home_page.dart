import 'package:flutter/material.dart';
import 'package:models/app/core/constants/categories.dart';
import 'package:models/app/ui/widgets/button_category_widget.dart';
import 'package:models/main.dart';
import 'package:models/routes.g.dart';
import 'package:routefly/routefly.dart';

final activeSession = supabase.auth.currentSession;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                Routefly.pushNavigate(routePaths.ui.pages.modelForm);
              },
              icon: const Icon(Icons.upload))
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          ...categories
              .map((category) => ButtonCategoryWidget(category: category))
        ],
      ),
    );
  }
}
