import 'package:districorp/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class EmployeeProfile extends StatefulWidget {
  const EmployeeProfile({super.key});

  @override
  State<EmployeeProfile> createState() => _EmployeeProfileState();
}

class _EmployeeProfileState extends State<EmployeeProfile> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _documentIdController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.start,
            
            children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Nombres',
                      prefixIcon: Icon(Icons.person),
                      
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      
                    ),
                    
                  ),
                                        
const SizedBox(height: 20),
                  TextField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      hintText: 'Apellidos',
                      prefixIcon: Icon(Icons.person),
                      
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      
                    ),
                    
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _telephoneController,
                    decoration: InputDecoration(
                      hintText: 'Telefono',
                      prefixIcon: Icon(Icons.local_phone_sharp),
                      
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      
                    ),
                    
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Correo',
                      prefixIcon: Icon(Icons.email),
                      
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      
                    ),
                    
                  ),
const SizedBox(height: 20),
                  TextField(
                    controller: _documentIdController,
                    decoration: InputDecoration(
                      hintText: 'Documento',
                      prefixIcon: Icon(Icons.assignment_ind_rounded),
                      
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      
                    ),
                    
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: 'Iniciar Sesión',
                    onPressed: (){},
                  ),
                ),
            ],
          ),
        ),
      );
  }
}