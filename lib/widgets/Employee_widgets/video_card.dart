import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const VideoCard({required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      
      shape: RoundedRectangleBorder(
        
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.fitHeight,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Nombre del video en la parte inferior
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Icono de menú (3 puntos) en la esquina superior derecha
          Positioned(
            top: -5,
            right: -5,
            child: PopupMenuButton<String>(
              onSelected: (value) {
                print("Opción seleccionada: $value");
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: 'download',
                    child: Text('Descargar'),
                  ),
                  const PopupMenuItem(
                    value: 'share',
                    child: Text('Compartir'),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Eliminar'),
                  ),
                ];
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(235, 2, 56, 1),
                    Color.fromRGBO(120, 50, 220, 1)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: IconButton(
                onPressed: () {
                  // Acción del botón de play
                },
                icon: Icon(
                  Icons.play_circle_fill,
                  color: Colors.white,
                  size: 45,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
