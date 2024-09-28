import 'package:districorp/constant/sizes.dart';
import 'package:flutter/material.dart';

class EmployeeHome extends StatelessWidget {
  const EmployeeHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InfoCard(
                size: size,
                titulo: "Streaming",
                subContenido:
                    "Transmite videos y audios sin necesidad de descargarlos. Reproduce tu contenido multimedia.",
                imageUrl: "assets/playimage.jpg",
                txtbtn: 'Mirar',
              ),
              const SizedBox(height: 30),
              InfoCard(
                size: size,
                titulo: "Photo Album",
                subContenido:
                    "Organiza y guarda tus fotos en álbumes digitales accesibles desde cualquier dispositivo.",
                imageUrl: "assets/photo_album.png",
                txtbtn: "Ingresar",
              ),
              const SizedBox(height: 30),
              InfoCard(
                size: size,
                titulo: "Shared Files",
                subContenido:
                    "Gestiona, sube y comparte archivos con tus compañeros de trabajo.",
                imageUrl: "assets/files.png",
                txtbtn: "Ingresar",
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String titulo;
  final String subContenido;
  final String imageUrl;
  final String txtbtn;

  const InfoCard({
    super.key,
    required this.size,
    required this.titulo,
    required this.subContenido,
    required this.imageUrl,
    required this.txtbtn,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8, // Increased shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            ClipRRect(
              child: Image.asset(
                imageUrl,
                fit: BoxFit.fill,
                width: size.width,
                height: size.height * 0.235,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, bottom: 16, top: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(titulo,
                      style: const TextStyle(
                          fontSize: cTitulosSize, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(
                    subContenido,
                    style: const TextStyle(fontSize: cSubcontenidoSize),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                      child: ElevatedButton.icon(
                    onPressed: () {},
                    label: Text(
                      txtbtn,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: cSubcontenidoSize,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(120, 50, 220, 1),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
