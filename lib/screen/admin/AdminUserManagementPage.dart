import 'package:districorp/controller/services/api.dart';
import 'package:districorp/widgets/SearchBarCustom.dart';
import 'package:districorp/widgets/UserItem_caja.dart';
import 'package:districorp/widgets/add_user.dart';
import 'package:districorp/widgets/update_user.dart';
import 'package:flutter/material.dart';
import 'package:districorp/widgets/custom_button.dart';
import 'package:districorp/widgets/gradient_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminUserManagementPage extends StatefulWidget {
  @override
  _AdminUserManagementPageState createState() =>
      _AdminUserManagementPageState();
}

class _AdminUserManagementPageState extends State<AdminUserManagementPage> {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredUsers = []; // Store user details
  List<Map<String, dynamic>> users = []; // Store all users here
  final ApiController apiController = ApiController();

  @override
  void initState() {
    super.initState();
    fetchUsers(); // Fetch users when the widget initializes
  }

  void filterUsers(String query) {
    final filtered = users.where((user) {
      final emailLower = user['email'].toLowerCase();
      final searchLower = query.toLowerCase();
      return emailLower.contains(searchLower);
    }).toList();

    setState(() {
      filteredUsers = filtered;
    });
  }

Future<void> fetchUsers() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  if (token != null) {
    // Fetch users with role 'User'
    var usersResponse = await apiController.obtenerUsuariosDistri("User", token);

    // Fetch users with role 'Employee'
    var employeesResponse = await apiController.obtenerUsuariosDistri("Employee", token);

    // Combine both lists of users
    var combinedUsers = [...usersResponse, ...employeesResponse];

    if (combinedUsers.isNotEmpty) {
      setState(() {
        users = combinedUsers; // Directly set the combined response as users
        filteredUsers = users; // Initialize filtered users
      });
    } else {
      print('No users found in response.');
    }
  } else {
    print('Token is null.');
  }
}


  Future<void> deleteUser(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    String rol = "User"; // Define the role here

    print("Token almacenado: '$token'"); // Add this line for debugging

    if (token != null) {
      try {
        // Call eliminarUsuariosDistri and pass the role and token
        await apiController.eliminarUsuariosDistri(email, rol, token);
        fetchUsers(); // Update the user list after deletion
      } catch (e) {
        print("Error al eliminar usuario: $e"); // Show any error
      }
    } else {
      print('Token is null, cannot delete user.');
    }
  }

  Future<void> _onRefresh() async {
    await fetchUsers(); // Refresh the user list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        implyLeading: true,
        title: 'Gestión de Usuarios',
      ),
      body: RefreshIndicator( // Wrap ListView in RefreshIndicator
        onRefresh: _onRefresh, // Function to call when refreshed
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SearchBarCustom(
                controller: searchController,
                onChanged: filterUsers,
                hintext: 'Buscar usuarios...',
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  return UserItem(
                    email: filteredUsers[index]['email'] ?? '',
                    name: filteredUsers[index]['name'] ?? '',
                    onUpdate: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateUserPage(
                            email: filteredUsers[index]['email'] ?? '',
                            name: filteredUsers[index]['name'] ?? '',
                            surname: filteredUsers[index]['surname'] ?? '',
                            phone: filteredUsers[index]['phone'] ?? '',
                            document: filteredUsers[index]['document'] ?? '',
                            role: filteredUsers[index]['role'] ?? '',
                          ),
                        ),
                      );
                    },
                    onDelete: () {
                      deleteUser(filteredUsers[index]['email'] ?? '');
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
      ),
    );
  }
}
