import 'package:flutter/material.dart';
import 'package:districorp/widgets/custom_input.dart';
import 'package:districorp/widgets/custom_button.dart';
import 'package:districorp/widgets/gradient_appbar.dart';
import 'package:districorp/controller/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateUserPage extends StatefulWidget {
  final String email;
  final String name;
  final String surname;
  final String phone;
  final String document;
  final String role;

  UpdateUserPage({
    required this.email,
    required this.name,
    required this.surname,
    required this.phone,
    required this.document,
    required this.role,
  });

  @override
  _UpdateUserPageState createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  final ApiController apiController = ApiController();

  // Role mapping
  final Map<String, String> roleMapping = {
    "Administrador": "Admin",
    "Empleado": "Employee",
    "Usuario": "User",
  };

  @override
  void initState() {
    super.initState();
    apiController.nombreActualizarController.text = widget.name;
    apiController.apellidolActualizarController.text = widget.surname;
    apiController.emailActualizarController.text = widget.email;
    apiController.phoneActualizarController.text = widget.phone;
    apiController.documentActualizarController.text = widget.document;
    apiController.rolActualizarController.text = widget.role;
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        implyLeading: true,
        title: 'Actualizar Usuario',
      ),
      resizeToAvoidBottomInset: true, 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomInput(
                hintText: 'Nombre',
                icon: Icons.person,
                controller: apiController.nombreActualizarController,
              ),
              const SizedBox(height: 16),
              CustomInput(
                hintText: 'Apellido',
                icon: Icons.person_outline,
                controller: apiController.apellidolActualizarController,
              ),
              const SizedBox(height: 16),
              CustomInput(
                hintText: 'Correo Electrónico',
                icon: Icons.email,
                controller: apiController.emailActualizarController,
              ),
              const SizedBox(height: 16),
              CustomInput(
                hintText: 'Teléfono',
                icon: Icons.phone,
                controller: apiController.phoneActualizarController,
              ),
              const SizedBox(height: 16),
              CustomInput(
                hintText: 'Documento',
                icon: Icons.file_present,
                controller: apiController.documentActualizarController,
              ),
              const SizedBox(height: 16),
              CustomInput(
                hintText: 'Rol',
                icon: Icons.assignment_ind,
                controller: apiController.rolActualizarController,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Actualizar',
                onPressed: () async {
                  String? token = await getToken();
                  if (token != null) {
                    // Map user-friendly role to API role before sending
                    String selectedRole = roleMapping[apiController.rolActualizarController.text] ?? "User"; // Default to 'User' if no match

                    final result = await apiController.actualizarUsuarioDistri(token, selectedRole); // Pass the mapped role
                    if (result != null && result == 200) {
                      print('Usuario actualizado correctamente');
                      Navigator.pop(context); // Return to the previous page
                    } else {
                      print('Error al actualizar el usuario');
                    }
                  } else {
                    print('No se pudo obtener el token.');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    apiController.dispose(); // Ensure to dispose controllers
    super.dispose();
  }
}
