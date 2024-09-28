import 'package:districorp/providers/Emp_dashboard_provider.dart';
import 'package:districorp/screen/Employee/Panel_principal_empleado.dart';
import 'package:districorp/screen/admin/Panel_principal_admin.dart';
import 'package:districorp/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EmpDashboardProvider>(
            create: (_) => EmpDashboardProvider())
      ],
      child: GetMaterialApp(
        scrollBehavior: MyBehavior(),
        debugShowCheckedModeBanner: false,
        initialRoute: 'Employee',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        routes: {
          'Login': (context) => const LoginScreen(),
          'Main': (context) => MainPanelPage(),
          'Employee': (context) => EmployeePanelPage(),
        },
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics();
}
