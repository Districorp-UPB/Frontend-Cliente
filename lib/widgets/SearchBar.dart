import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Buscar usuarios...',
        hintStyle: TextStyle(color: Colors.grey), 
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.black, 
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey), 
        ),
        filled: true, 
        fillColor: Colors.white, 
      ),
    );
  }
}
