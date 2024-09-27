import 'package:flutter/material.dart';

class EmployeeAlbum extends StatelessWidget {
  const EmployeeAlbum({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Photo Album Employee")
            ],
          ),
        ),
      );
  }
}