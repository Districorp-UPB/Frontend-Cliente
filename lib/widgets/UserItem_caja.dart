import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final String email;
  final String name;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;

  const UserItem({
    Key? key,
    required this.email,
    required this.name,
    required this.onUpdate,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(name),
        subtitle: Text(email),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue), 
              onPressed: onUpdate,
            ),
            IconButton(
             icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}