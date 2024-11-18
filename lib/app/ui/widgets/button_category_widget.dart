import 'package:flutter/material.dart';
import 'package:models/routes.g.dart';
import 'package:routefly/routefly.dart';

class ButtonCategoryWidget extends StatelessWidget {
  final String category;
  const ButtonCategoryWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        style: TextButton.styleFrom(
          elevation: 10,
          // backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Bordas quadradas
            side: const BorderSide(
              color: Colors.black, // Cor da borda
              width: 2, // Largura da borda
            ),
          ),
        ),
        onPressed: () {
          Routefly.pushNavigate(routePaths.ui.pages.category,
              arguments: category);
        },
        child: Text(
          category.toUpperCase(),
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
