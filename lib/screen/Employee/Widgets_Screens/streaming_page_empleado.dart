// lib/widgets/employee_streaming.dart
import 'dart:typed_data';
import 'package:districorp/constant/sizes.dart';
import 'package:districorp/controller/services/api.dart';
import 'package:districorp/widgets/Employee_widgets/video_card.dart';
import 'package:districorp/widgets/SearchBarCustom.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeStreaming extends StatefulWidget {
  const EmployeeStreaming({super.key});

  @override
  _EmployeeStreamingState createState() => _EmployeeStreamingState();
}

class _EmployeeStreamingState extends State<EmployeeStreaming> {
  final TextEditingController searchController = TextEditingController();
  final List<Map<String, String>> streamingVideos = [
    {"title": "Venom 3", "image": "assets/video1.png"},
    {"title": "Joker 2", "image": "assets/video2.png"},
    {"title": "Gladiator 2", "image": "assets/video3.png"},
  ];
  List<Map<String, String>> filteredVideos = [];
  final ApiController apiController = ApiController(); // Crear instancia de ApiController

  @override
  void initState() {
    super.initState();
    filteredVideos = streamingVideos; // Inicialmente mostrar todos los videos
  }

  void filterVideos(String query) {
    final filtered = streamingVideos.where((video) {
      final titleLower = video['title']!.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      filteredVideos = filtered;
    });
  }

  // Función para seleccionar y subir un video
  Future<void> _pickAndUploadVideo() async {
    // Usar FilePicker para seleccionar un video
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.video, // Solo permitir selección de videos
    );

    if (result != null) {
      Uint8List? fileBytes = result.files.single.bytes;
      String fileName = result.files.single.name;

      if (fileBytes != null) {
        // Obtener el token desde SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');

        if (token != null) {
          // Subir video al servidor usando la instancia de ApiController
          int? responseCode = await apiController.subirVideoEmpleadoDistri(token, fileBytes, fileName);
          if (responseCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Video subido exitosamente')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error al subir el video')),
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
            onChanged: filterVideos,
            hintext: "Buscar videos...",
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
              itemCount: filteredVideos.length,
              itemBuilder: (context, index) {
                final video = filteredVideos[index];
                return VideoCard(
                  title: video['title']!,
                  imageUrl: video['image']!,
                );
              },
            ),
          ),
        ),
        Column(
          children: [
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
                    onPressed: _pickAndUploadVideo, // Llama a la función para subir el video
                    icon: Icon(
                      Icons.arrow_circle_down_outlined,
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
                    "Subir Video",
                    style: TextStyle(
                      color: Colors.white, // Esto es necesario aunque será cubierto por el shader
                      fontSize: cSubcontenidoSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
