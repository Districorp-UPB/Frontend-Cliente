import 'package:districorp/screen/Employee/Widgets_Screens/album_page_empleado.dart';
import 'package:districorp/screen/Employee/Widgets_Screens/files_page_empleado.dart';
import 'package:districorp/screen/Employee/Widgets_Screens/home_page_empleado.dart';
import 'package:districorp/screen/Employee/Widgets_Screens/perfil_page_empleado.dart';
import 'package:districorp/screen/Employee/Widgets_Screens/streaming_page_empleado.dart';
import 'package:flutter/material.dart';

class EmpDashboardProvider extends ChangeNotifier{

  // Index para manejo de vistas en el dashboard de Employee
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Widget getSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return EmployeeHome();
      case 1:
        return EmployeeProfile();
      case 2:
        return EmployeeStreaming();
      case 3:
        return EmployeeAlbum();
      case 4:
        return EmployeeFiles();
        
      default:
        return Container();
    }
  }

  String getTitle(int index){
    switch (index) {
      case 0:
        return "Employee Home";
      case 1:
        return "Employee Profile";
      case 2:
        return "Employee Streaming";
      case 3:
        return "Employee Album";
      case 4:
        return "Employee Files";

      default:
        return "";
    }
  }

}

