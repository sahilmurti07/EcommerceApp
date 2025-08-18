// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class mytextfields extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  bool obscureText;
  final String? Function(String?)? validator;

  mytextfields({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    this.validator, // ✅ add validator parameter
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: TextFormField(
        // ✅ use TextFormField instead of TextField
        controller: controller,
        obscureText: obscureText,
        validator: validator, // ✅ hook up validator
        decoration: InputDecoration(
          floatingLabelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          filled: true,
          fillColor: Colors.grey[400],
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
