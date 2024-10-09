import 'dart:convert';

import 'package:districorp/controller/services/api_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiController {
// Metodos de login y inicio de sesion de la app

  // Controladores de texto de Inicio de Sesion y Registro
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController tipoRolController = TextEditingController();

  Future<Map<String, dynamic>> loginU() async {
    try {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {

        Map<String, String> rolesMap = {
          "Administrador": "Admin",
          "Empleado": "Employee",
          "Usuario": "User",
        };

        String? rolTipoConvertido = rolesMap[tipoRolController.text];

        Map<String, String> regBody = {
          "email": emailController.text,
          "password": passwordController.text,
          "ou": rolTipoConvertido!,
        };
        print(regBody);
        
        print(loginUrl);

        var responseLogin = await http.post(Uri.parse("http://192.168.1.9:4000/api/authenticate"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(regBody));
        print("Paso");
        var jsonResponseLog = jsonDecode(responseLogin.body);

        print("Token: ${jsonResponseLog['token']}");
        print("Respuesta Login: ${responseLogin.statusCode}");

        if (responseLogin.statusCode == 200) {
          return jsonResponseLog;
        } else if (responseLogin.statusCode == 404) {
          // handleRegistrationError(
          //     responseLogin.statusCode, jsonResponseLog['msg']);
          throw Exception("Error 404");
        } else if (responseLogin.statusCode == 400) {
          // handleRegistrationError(
          //     responseLogin.statusCode, jsonResponseLog['msg']);
          throw Exception("Error 400");
        } else {
          throw Exception("Error en la : ${responseLogin.statusCode}");
        }
      } else {
        throw Exception("El correo y la contraseña son obligatorios");
      }
    } catch (e) {
      print("Error en la solicitud: $e");
      return {};
    }
  }
}
