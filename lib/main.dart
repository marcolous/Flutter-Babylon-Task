import 'package:babylon_task/auth/login_view/login_view.dart';
import 'package:babylon_task/auth/register_view/register_view.dart';
import 'package:babylon_task/core/utils/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Babylon());
}

class Babylon extends StatelessWidget {
  const Babylon({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginView(),
      routes: {
        Routes.kLoginScreen: (context) => const LoginView(),
        Routes.kRegisterScreen: (context) => const RegisterView(),
        // Routes.kHomeScreen: (context) => const HomeScreen(),
      },
    );
  }
}
