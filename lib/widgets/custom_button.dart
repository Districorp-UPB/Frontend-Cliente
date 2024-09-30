import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon; // Icono opcional

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon, // Parámetro opcional
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(235, 2, 56, 1),
            Color.fromRGBO(120, 50, 220, 1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(7), // Bordes redondeados
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon != null
            ? Icon(icon, color: Colors.white) // Ícono con color blanco
            : const SizedBox.shrink(), // Si no hay ícono, se oculta
        label: Text(
          text,
          style: const TextStyle(color: Colors.white), // Texto blanco
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          backgroundColor: Colors.transparent, // Fondo transparente
          shadowColor: Colors.transparent, // Sin sombra
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7), // Bordes redondeados
          ),
        ),
      ),
    );
  }
}
