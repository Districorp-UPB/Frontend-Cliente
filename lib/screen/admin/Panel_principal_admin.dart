import 'package:districorp/screen/login_screen.dart';
import 'package:districorp/widgets/OptionCard.dart';
import 'package:flutter/material.dart';
import 'package:districorp/widgets/gradient_appbar.dart';
import 'package:districorp/screen/admin/AdminUserManagementPage.dart';
import 'package:get/get.dart';

class MainPanelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        implyLeading: false,
        title: 'Panel Principal',
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              print('Logout');
              Get.to(() => const LoginScreen());
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Selecciona una opción',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              OptionCard(
                title: 'Gestión de Usuarios',
                icon: Icons.people,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminUserManagementPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              OptionCard(
                title: 'Inhabilitar Usuarios',
                icon: Icons.block,
                onTap: () {
                  // Implement functionality for disabling users
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
