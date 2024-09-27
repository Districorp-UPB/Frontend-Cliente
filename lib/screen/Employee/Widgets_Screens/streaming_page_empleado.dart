import 'package:flutter/material.dart';

class EmployeeStreaming extends StatelessWidget {
  const EmployeeStreaming({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Streaming Employee")
            ],
          ),
        ),
      );
  }
}