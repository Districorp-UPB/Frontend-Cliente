import 'package:flutter/material.dart';
import 'package:districorp/widgets/custom_input.dart';
import 'package:districorp/widgets/custom_button.dart';
import 'package:districorp/widgets/gradient_appbar.dart';

class AddUserPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: 'Agregar Usuario',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomInput(
              hintText: 'Nombre',
              icon: Icons.person,
              controller: nameController,
            ),
            const SizedBox(height: 16),
            CustomInput(
              hintText: 'Correo Electrónico',
              icon: Icons.email,
              controller: emailController,
            ),
            const SizedBox(height: 16),
            CustomInput(
              hintText: 'Teléfono',
              icon: Icons.phone,
              controller: phoneController,
            ),
            const SizedBox(height: 16),
            CustomInput(
              hintText: 'Contraseña',
              icon: Icons.lock,
              controller: passwordController,
              isPassword: true,  // Asegúrate de que la contraseña esté oculta
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Guardar',
              onPressed: () {
                // Implementar la lógica de agregar usuario aquí
                print('Usuario agregado: ${nameController.text}, ${emailController.text}, ${phoneController.text}, ${passwordController.text}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
