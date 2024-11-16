import 'package:flutter/material.dart';

class DropDownCategoryWidget extends StatelessWidget {
  const DropDownCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(items: [
      DropdownMenuItem(child: Text("USA"), value: "USA"),
      DropdownMenuItem(child: Text("Canada"), value: "Canada"),
      DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
      DropdownMenuItem(child: Text("England"), value: "England"),
    ], onChanged: (_) {});
  }
}
