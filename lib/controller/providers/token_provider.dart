import 'package:districorp/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TokenProvider extends ChangeNotifier {
  late String email;
  late String name;
  late String lastname;
  late dynamic tokenw;


  Future<String?> verificarTokenU({bool? rol}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenActual = prefs.getString('token');
    // Verificar si el token está presente y está expirado
    if (tokenActual != null && JwtDecoder.isExpired(tokenActual)) {
      // Borrar el token si está expirado
      await prefs.remove('token');

      Get.to(() => const LoginScreen());
      throw Exception("El token ha expirado!");
    } else if (tokenActual != null) {

      print(tokenActual);
      return tokenActual;
    } else {
      Get.to(() => const LoginScreen());
      throw Exception("No hay token");
    }
  }

  // Para cuando se inicializa la app y verificar el estado
  Future<String?> getTokenU() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenActual = prefs.getString('token');
    // Verificar si el token está presente y está expirado
    if (tokenActual != null && JwtDecoder.isExpired(tokenActual)) {
      // Borrar el token si está expirado
      await prefs.remove('token');
      return tokenActual;
    } else {
      // ignore: avoid_print
      print(tokenActual);
      return tokenActual;
    }
  }

  Future<void> setTokenU(String result) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', result);
  }



  Future<void> eliminarTokenU() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenActual = prefs.getString('token');

    // Verificar si el token está presente
    if (tokenActual != null) {
      // Borrar el token
      await prefs.remove('token');
      Get.to(() => const LoginScreen());
      throw Exception("Token eliminado");
    }
  }
}
