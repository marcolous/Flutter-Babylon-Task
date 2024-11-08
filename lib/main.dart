import 'package:babylon_task/cubits/auth_cubit/auth_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:babylon_task/auth/login_view/login_view.dart';
import 'package:babylon_task/auth/register_view/register_view.dart';
import 'package:babylon_task/core/utils/routes.dart';
import 'package:babylon_task/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Babylon());
}

class Babylon extends StatelessWidget {
  const Babylon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const LoginView(),
        routes: {
          Routes.kLoginScreen: (context) => const LoginView(),
          Routes.kRegisterScreen: (context) => const RegisterView(),
          // Routes.kHomeScreen: (context) => const HomeScreen(),
        },
      ),
    );
  }
}
