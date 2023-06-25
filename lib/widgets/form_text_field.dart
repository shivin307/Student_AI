import 'package:flutter/material.dart';

import '../data/constants.dart';

class formTextField extends StatelessWidget {
  final MapEntry<String, dynamic> field;
  final Map<String, TextEditingController> formFieldControllers;

  const formTextField(
      {Key? key, required this.field, required this.formFieldControllers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: typeMap[field.value['type']],
      controller: formFieldControllers[field.key],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintText: field.value['placeholder'],
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(21),
          borderSide: BorderSide(
            color: iradium.withOpacity(0.8),
            width: 3,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field can't be empty";
        } else {
          return null;
        }
      },
    );
  }
}
