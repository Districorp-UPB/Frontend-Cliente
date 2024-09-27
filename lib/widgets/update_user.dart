import 'package:flutter/material.dart';
import 'package:districorp/widgets/custom_input.dart';
import 'package:districorp/widgets/custom_button.dart';
import 'package:districorp/widgets/gradient_appbar.dart';

class UpdateUserPage extends StatelessWidget {
  final String email; // Correo del usuario que se va a actualizar
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  UpdateUserPage({required this.email});

  @override
  Widget build(BuildContext context) {
    emailController.text = email;

    return Scaffold(
      appBar: GradientAppBar(
        implyLeading: false,
        title: 'Actualizar Usuario',
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
            const SizedBox(height: 24),
            CustomButton(
              text: 'Actualizar',
              onPressed: () {
                print('Usuario actualizado: ${nameController.text}, ${emailController.text}, ${phoneController.text}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
