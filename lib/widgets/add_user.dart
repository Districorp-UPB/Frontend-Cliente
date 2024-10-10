import 'package:flutter/material.dart';
import 'package:districorp/controller/services/api.dart';
import 'package:districorp/widgets/custom_input.dart';
import 'package:districorp/widgets/custom_button.dart';
import 'package:districorp/widgets/gradient_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final TextEditingController nombreNewController = TextEditingController();
  final TextEditingController apellidolNewController = TextEditingController();
  final TextEditingController emailNewController = TextEditingController();
  final TextEditingController phoneNewController = TextEditingController();
  final TextEditingController documentNewController = TextEditingController();
  final TextEditingController passwordNewController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Key for the form

  String selectedRole = 'Usuario'; // Default role

  final List<String> roles = ['Administrador', 'Empleado', 'Usuario']; // List of roles

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> showConfirmationDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Usuario Agregado'),
          content: Text('El usuario se ha agregado con éxito.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        implyLeading: true, // Change to true to show back button
        title: 'Agregar Usuario',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Wrap in SingleChildScrollView
          child: Form( // Use the Form widget
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // Align elements to full width
              children: [
                CustomInput(
                  hintText: 'Nombre',
                  icon: Icons.person,
                  controller: nombreNewController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa un nombre.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomInput(
                  hintText: 'Apellido',
                  icon: Icons.person_outline,
                  controller: apellidolNewController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa un apellido.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomInput(
                  hintText: 'Correo Electrónico',
                  icon: Icons.email,
                  controller: emailNewController,
                  validator: (value) {
                    if (value!.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Por favor ingresa un correo electrónico válido.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomInput(
                  hintText: 'Teléfono',
                  icon: Icons.phone,
                  controller: phoneNewController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa un número de teléfono.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomInput(
                  hintText: 'Documento',
                  icon: Icons.file_present,
                  controller: documentNewController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa un documento.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomInput(
                  hintText: 'Contraseña',
                  icon: Icons.lock,
                  controller: passwordNewController,
                  isPassword: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa una contraseña.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButton<String>(
                  value: selectedRole,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRole = newValue!;
                    });
                  },
                  items: roles.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: 'Guardar',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) { // Validate the form
                      // Get the token from local storage
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      String? token = prefs.getString('token');

                      if (token != null) {
                        var apiController = ApiController();

                        // Call the method registrarUsuarioDistri with all necessary fields
                        int? result = await apiController.registrarUsuarioDistri(
                          token,
                          nombreNewController.text,
                          apellidolNewController.text,
                          emailNewController.text,
                          phoneNewController.text,
                          documentNewController.text,
                          passwordNewController.text,
                          selectedRole,
                        );

                        if (result == 200) {
                          showSnackBar('Usuario agregado con éxito');
                          showConfirmationDialog(); // Show confirmation dialog
                          // Clear the fields after adding the user
                          nombreNewController.clear();
                          apellidolNewController.clear();
                          emailNewController.clear();
                          phoneNewController.clear();
                          documentNewController.clear();
                          passwordNewController.clear();
                        } else {
                          print('Error al agregar el usuario');
                          showSnackBar('Error al agregar el usuario');
                        }
                      } else {
                        print('Token no encontrado');
                        showSnackBar('Token no encontrado');
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
