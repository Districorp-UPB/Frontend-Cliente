import 'package:districorp/screen/admin/AdminUserManagementPage.dart';
import 'package:flutter/material.dart';// Importa la vista de login

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: AdminUserManagementPage(),
    );
  }
}
