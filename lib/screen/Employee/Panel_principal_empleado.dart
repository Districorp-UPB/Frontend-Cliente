import 'package:districorp/constant/sizes.dart';
import 'package:districorp/providers/Emp_dashboard_provider.dart';
import 'package:districorp/screen/login_screen.dart';
import 'package:districorp/widgets/Employee_widgets/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:districorp/widgets/gradient_appbar.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class EmployeePanelPage extends StatefulWidget {
  @override
  State<EmployeePanelPage> createState() => _EmployeePanelPageState();
}

class _EmployeePanelPageState extends State<EmployeePanelPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final employeeProvider = Provider.of<EmpDashboardProvider>(context);
    return Scaffold(
      appBar: GradientAppBar(
        implyLeading: true,
        title: employeeProvider.getTitle(employeeProvider.selectedIndex),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              print('Logout');
              Get.to(() => const LoginScreen());
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(235, 2, 56, 1),
                Color.fromRGBO(120, 50, 220, 1)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              // Se utiliza un Container en lugar de DrawerHeader para evitar la línea divisora

              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.all(cDefaultSize - 15),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        employeeProvider.updateSelectedIndex(0);

                        Navigator.pop(context);
                      },
                      child: Image(
                        image: AssetImage("assets/logo_3.png"),
                        height: 130,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 4),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person,
                    color: Colors.white, size: size.height * 0.08),
              ),
              SizedBox(
                height: cDefaultSize,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerTile(
                      size: size,
                      texto: "Editar Perfil",
                      icono: Icons.edit,
                      onTap: () {
                        // Actualizar el indice de las paginas
                        employeeProvider.updateSelectedIndex(1);
                        // Cerrar el drawer
                        Navigator.pop(context);
                      },
                      selected: employeeProvider.selectedIndex == 1, color: Colors.amber,
                    ),
                    DrawerTile(
                      size: size,
                      texto: "Streaming",
                      icono: Icons.play_circle_sharp,
                      onTap: () {
                        // Actualizar el indice de las paginas
                        employeeProvider.updateSelectedIndex(2);
                        // Cerrar el drawer
                        Navigator.pop(context);
                      },
                      selected: employeeProvider.selectedIndex == 2, color: Colors.amber,
                    ),
                    DrawerTile(
                      size: size,
                      texto: "Photo Album",
                      icono: Icons.photo_camera_back_sharp,
                      onTap: () {
                        // Actualizar el indice de las paginas
                        employeeProvider.updateSelectedIndex(3);
                        // Cerrar el drawer
                        Navigator.pop(context);
                      },
                      selected: employeeProvider.selectedIndex == 3, color: Colors.amber,
                    ),
                    DrawerTile(
                      size: size,
                      texto: "Files",
                      icono: Icons.upload_file_sharp,
                      onTap: () {
                        // Actualizar el indice de las paginas
                        employeeProvider.updateSelectedIndex(4);
                        // Cerrar el drawer
                        Navigator.pop(context);
                      },
                      selected: employeeProvider.selectedIndex == 4, color: Colors.amber,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: EmpDashboardPage(
          widgetScreensOptions: employeeProvider.getSelectedPage(),
        ),
    );
  }
}

class EmpDashboardPage extends StatelessWidget {
  final Widget widgetScreensOptions;

  const EmpDashboardPage({
    super.key,
    required this.widgetScreensOptions,
  });

  @override
  Widget build(BuildContext context) {
    return widgetScreensOptions;
  }
}


