import 'dart:typed_data';
import 'package:districorp/controller/services/api.dart';
import 'package:districorp/widgets/SearchBarCustom.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeAlbum extends StatefulWidget {
  const EmployeeAlbum({super.key});

  @override
  _EmployeeAlbumState createState() => _EmployeeAlbumState();
}

class _EmployeeAlbumState extends State<EmployeeAlbum> {
  final TextEditingController searchController = TextEditingController();
  Uint8List? _selectedImageBytes; // Para almacenar la imagen seleccionada
  String? _selectedImageName; // Para almacenar el nombre de la imagen seleccionada
  final ApiController _apiController = ApiController(); // Instancia del controlador de API

  // Función para seleccionar imagen desde el dispositivo
  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _selectedImageBytes = result.files.single.bytes;
        _selectedImageName = result.files.single.name;
      });
    }
  }

  // Función para subir la imagen al servidor
  Future<void> _uploadImage() async {
    if (_selectedImageBytes != null && _selectedImageName != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token'); // Recuperar el token de local storage
      if (token != null) {
        int? responseCode = await _apiController.subirFotoEmpleadoDistri(
          token,
          _selectedImageBytes!,
          _selectedImageName!,
        );
        if (responseCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Imagen subida exitosamente')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al subir la imagen')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Token no encontrado')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor selecciona una imagen')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: SearchBarCustom(
            controller: searchController,
            onChanged: (String query) {}, // No es necesario en esta versión
            hintext: "Buscar fotos...",
          ),
        ),
        if (_selectedImageBytes != null && _selectedImageName != null)
          Column(
            children: [
              Image.memory(
                _selectedImageBytes!,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text(_selectedImageName!),
            ],
          ),
        Spacer(),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(235, 2, 56, 1),
                    Color.fromRGBO(120, 50, 220, 1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: IconButton(
                onPressed: _pickImage, // Selección de imagen
                icon: Icon(
                  Icons.add_photo_alternate_sharp,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ],
    );
  }
}
