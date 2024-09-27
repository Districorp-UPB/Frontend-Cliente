import 'package:districorp/widgets/UserItem_caja.dart';
import 'package:districorp/widgets/add_user.dart';
import 'package:districorp/widgets/update_user.dart';
import 'package:flutter/material.dart';
import 'package:districorp/widgets/custom_button.dart';
import 'package:districorp/widgets/gradient_appbar.dart';

class AdminUserManagementPage extends StatefulWidget {
  @override
  _AdminUserManagementPageState createState() =>
      _AdminUserManagementPageState();
}

class _AdminUserManagementPageState extends State<AdminUserManagementPage> {
  final TextEditingController searchController = TextEditingController();
  final List<String> users = [
    'user1@example.com',
    'user2@example.com',
    'user3@example.com'
  ];
  List<String> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    filteredUsers = users;
  }

  void filterUsers(String query) {
    final filtered = users.where((user) {
      final emailLower = user.toLowerCase();
      final searchLower = query.toLowerCase();
      return emailLower.contains(searchLower);
    }).toList();

    setState(() {
      filteredUsers = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: GradientAppBar(
        implyLeading: false,
        title: 'Gestión de Usuarios',
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SearchBar(

                  controller: searchController,
                  onChanged: filterUsers,
                  hintText: 'Buscar usuarios...',
                  hintStyle: WidgetStateProperty.all<TextStyle>(
                      TextStyle(color: Colors.grey)),
                ),
                Positioned(
                    right: size.width * 0.05,
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                return UserItem(
                  email: filteredUsers[index],
                  onUpdate: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UpdateUserPage(email: filteredUsers[index]),
                      ),
                    );
                  },
                  onDelete: () {
                    // implementar para eliminar usuarios
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: 'Agregar Usuario',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddUserPage(),
                  ),
                );
              },
              icon: Icons.add,
            ),
          ),
        ],
      ),
    );
  }
}
