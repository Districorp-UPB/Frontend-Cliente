
import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color titleColor;
  final List<Widget>? actions; // Add the actions parameter
  final bool implyLeading;

  const GradientAppBar({
    super.key, 
    this.title,
    this.titleColor = Colors.white,
    this.actions, // Initialize the actions parameter
    required this.implyLeading, 
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: implyLeading,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title != null ? Text(
            title!,
            style: TextStyle(color: titleColor),
          ) :
          Text("")
        ],
      ),
      actions: actions, // Use the actions in the AppBar
      iconTheme: IconThemeData(color: titleColor),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromRGBO(235, 2, 56, 1), Color.fromRGBO(120, 50, 220, 1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
