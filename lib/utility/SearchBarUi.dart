import 'package:flutter/material.dart';

class SearchBarUi extends StatelessWidget {
  final String hint;
  final ValueChanged<String> onChanged;
  final TextEditingController; // callback to pass search text

  const SearchBarUi({
    super.key,
    required this.hint,
    required this.onChanged,
    this.TextEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextField(
        controller: TextEditingController, // 🔹 controller to manage text input
        onChanged: onChanged, // 🔹 whenever text changes, pass it back
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: const Icon(Icons.search, color: Colors.black),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.3),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.5),
              width: 0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.8),
              width: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
