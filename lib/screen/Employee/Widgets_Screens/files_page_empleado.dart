// lib/widgets/Employee_files.dart
import 'dart:typed_data';
import 'package:districorp/constant/sizes.dart';
import 'package:districorp/controller/services/api.dart';
import 'package:districorp/widgets/Employee_widgets/file_card.dart';
import 'package:districorp/widgets/SearchBarCustom.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeFiles extends StatefulWidget {
  const EmployeeFiles({super.key});

  @override
  _EmployeeFilesState createState() => _EmployeeFilesState();
}

class _EmployeeFilesState extends State<EmployeeFiles> {
  final TextEditingController searchController = TextEditingController();
  final List<Map<String, String>> streamingAlbums = [
    {"title": "Reporte Ambiental", "image": "assets/texto1.txt"},
    {"title": "Infografia Etica Moral", "image": "assets/text2.txt"},
    {"title": "Documento Parcial 3", "image": "assets/texto3.txt"},
  ];
  List<Map<String, String>> filteredAlbums = [];
  final ApiController apiController = ApiController(); // Crear instancia de ApiController

  @override
  void initState() {
    super.initState();
    filteredAlbums = streamingAlbums; // Inicialmente mostrar todos los albunes
  }

  void filterAlbum(String query) {
    final filtered = streamingAlbums.where((video) {
      final titleLower = video['title']!.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      filteredAlbums = filtered;
    });
  }

  // Función para seleccionar y subir un archivo
  Future<void> _pickAndUploadFile() async {
    // Usar FilePicker para seleccionar un archivo
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any, // Puedes ajustar esto según tus necesidades
    );

    if (result != null) {
      Uint8List? fileBytes = result.files.single.bytes;
      String fileName = result.files.single.name;

      if (fileBytes != null) {
        // Obtener el token desde SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');

        if (token != null) {
          // Subir archivo al servidor usando la instancia de ApiController
          int? responseCode = await apiController.subirArchivoEmpleadoDistri(token, fileBytes, fileName);
          if (responseCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Archivo subido exitosamente')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error al subir el archivo')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Token no encontrado')),
          );
        }
      }
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
            onChanged: filterAlbum,
            hintext: "Buscar archivos...",
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columnas por fila
                crossAxisSpacing: 16, // Espacio horizontal entre tarjetas
                mainAxisSpacing: 16, // Espacio vertical entre tarjetas
                childAspectRatio: 0.75, // Relación de aspecto
              ),
              itemCount: filteredAlbums.length,
              itemBuilder: (context, index) {
                final video = filteredAlbums[index];
                return FileCard(
                  title: video['title']!,
                  fileUrl: video['image']!,
                );
              },
            ),
          ),
        ),
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
                onPressed: _pickAndUploadFile, // Llama a la función para subir el archivo
                icon: Icon(
                  Icons.upload_file_sharp,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [
                    Color.fromRGBO(235, 2, 56, 1),
                    Color.fromRGBO(120, 50, 220, 1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: Text(
                "Subir Archivo",
                style: TextStyle(
                  color: Colors.white, // Esto es necesario aunque será cubierto por el shader
                  fontSize: cSubcontenidoSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
