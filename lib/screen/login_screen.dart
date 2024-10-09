import 'package:districorp/controller/providers/token_provider.dart';
import 'package:districorp/controller/services/api.dart';
import 'package:districorp/screen/admin/Panel_principal_admin.dart';
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

  // Inicializamos una variable para controlar la visibilidad de la contraseña
  bool visiIcon = false;

  visibilityIcon() {
    setState(() {
      visiIcon = !visiIcon;
    });
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
                        Color.fromRGBO(120, 50, 220, 1)
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
                ),
                const SizedBox(height: 20),
                FormularioSelect(
                  opciones: const ["Usuario", "Empleado", "Administrador"],
                  controller: apiController.tipoRolController,
                  texto: "Tipo de Rol",
                  icono: const Icon(Icons.groups),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: apiController.passwordController,
                  obscureText: visiIcon ? false : true,
                  decoration: InputDecoration(
                      hintText: 'Contraseña',
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Contraseña",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                          splashColor: Colors.transparent,
                          onPressed: () {
                            visibilityIcon();
                          },
                          icon: visiIcon
                              ? const Icon(
                                  Icons.remove_red_eye_sharp,
                                )
                              : const Icon(Icons.visibility_off))),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: 'Iniciar Sesión',
                    onPressed: () async {
                      try {
                        // Llamar a la función de registro en el AuthController
                        dynamic result = await apiController.loginU();
                        if (result != {}) {
                          tokenProvider.setTokenU(result['token']);
                          Get.to(() => MainPanelPage());
                        }
                      } catch (e) {
                        print("Error al registrar usuario: $e");
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: TextButton(
                    onPressed: () {},
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
    );
  }
}
