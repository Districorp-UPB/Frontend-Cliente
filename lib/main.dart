import 'package:districorp/controller/providers/Emp_dashboard_provider.dart';
import 'package:districorp/controller/providers/token_provider.dart';
import 'package:districorp/screen/Employee/Panel_principal_empleado.dart';
import 'package:districorp/screen/admin/Panel_principal_admin.dart';
import 'package:districorp/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  // Garantiza que los widgets estén inicializados antes de ejecutar la aplicación.
  WidgetsFlutterBinding.ensureInitialized();

  // Obtener una instancia de TokenProvider
  TokenProvider tokenProvider = TokenProvider();

  // Llamar al método verificarTokenU() y esperar su resultado si existe token
  String? token = await tokenProvider.getTokenU();

  runApp(MyApp(
    token: token,
  ));
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EmpDashboardProvider>(
            create: (_) => EmpDashboardProvider()),
        ChangeNotifierProvider<TokenProvider>(create: (_) => TokenProvider())
      ],
      child: GetMaterialApp(
        scrollBehavior: MyBehavior(),
        debugShowCheckedModeBanner: false,
        initialRoute: (token != null) ? 'Main' : 'Login',
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
