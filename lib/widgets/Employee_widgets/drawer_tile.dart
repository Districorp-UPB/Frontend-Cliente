import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String texto;
  final IconData icono;
  final void Function()? onTap;
  final bool selected;
  final Color? color;

  const DrawerTile({
    super.key,
    required this.size,
    required this.texto,
    required this.icono,
    this.onTap,
    required this.selected, 
    required this.color,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icono,
        size: size.height * 0.04,
      ),
      selected: selected,
      selectedColor: color,
      textColor: Colors.white,
      iconColor: Colors.white,
      title: Text(
        texto,
        style: TextStyle(fontSize: 20),
      ),
      onTap: onTap,
    );
  }
}