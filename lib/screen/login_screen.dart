import 'package:districorp/controller/providers/token_provider.dart';
import 'package:districorp/controller/services/api.dart';
import 'package:districorp/screen/admin/Panel_principal_admin.dart';
import 'package:districorp/screen/employee/Panel_principal_empleado.dart';
import 'package:districorp/widgets/formulario_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../widgets/gradient_appbar.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ApiController apiController = ApiController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Inicializamos una variable para controlar la visibilidad de la contraseña
  bool visiIcon = false;

  visibilityIcon() {
    setState(() {
      visiIcon = !visiIcon;
    });
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu correo electrónico';
    }
    // Verificar el formato del correo electrónico
    const pattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Ingresa un correo electrónico válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu contraseña';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final tokenProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const GradientAppBar(
        implyLeading: false,
        titleColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey, // Agregar el formulario
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo_3.png',
                    height: 130,
                  ),
                  const SizedBox(height: 10),
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [
                          Color.fromRGBO(235, 2, 56, 1),
                          Color.fromRGBO(120, 50, 220, 1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    child: const Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        fontSize: 26,
                        color: Color.fromARGB(255, 194, 51, 51),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomInput(
                    hintText: 'Correo Electrónico',
                    icon: Icons.email,
                    controller: apiController.emailController,
                    validator: _validateEmail, // Validación para el correo
                  ),
                  const SizedBox(height: 20),
                  FormularioSelect(
                    opciones: const ["Usuario", "Empleado", "Administrador"],
                    controller: apiController.tipoRolController,
                    texto: "Tipo de Rol",
                    icono: const Icon(Icons.groups),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: apiController.passwordController,
                    obscureText: !visiIcon,
                    validator: _validatePassword, // Validación para la contraseña
                    decoration: InputDecoration(
                      hintText: 'Contraseña',
                      prefixIcon: const Icon(Icons.lock),
                      labelText: "Contraseña",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        splashColor: Colors.transparent,
                        onPressed: visibilityIcon,
                        icon: visiIcon
                            ? const Icon(Icons.remove_red_eye_sharp)
                            : const Icon(Icons.visibility_off),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'Iniciar Sesión',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) { // Verificar la validez del formulario
                          try {
                            // Call the login method
                            Map<String, dynamic> result = await apiController.loginDistri();
                            if (result.isNotEmpty) {
                              tokenProvider.setTokenU(result['token']);

                              // Redirect based on user role
                              switch (result['rol']) {
                                case 'Admin':
                                  Get.to(() => MainPanelPage());
                                  break;
                                case 'Employee':
                                  Get.to(() => EmployeePanelPage());
                                  break;
                                case 'User':
                                  Get.to(() => MainPanelPage());
                                  break;
                                default:
                                  // Handle unknown role if necessary
                                  break;
                              }
                            }
                          } catch (e) {
                            // Mostrar un mensaje de error si la autenticación falla
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Error al iniciar sesión: $e"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        // Implementar la lógica para la recuperación de contraseña.
                      },
                      child: const Text(
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
