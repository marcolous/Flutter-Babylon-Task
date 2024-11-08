import 'package:babylon_task/features/home_view/home_view_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingButton(),
      body: const SafeArea(
        child: HomeViewBody(),
      ),
    );
  }

  FloatingActionButton floatingButton() {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: () => FirebaseAuth.instance.signOut(),
      child: const Icon(
        Icons.logout_outlined,
        color: Colors.black,
        size: 30,
      ),
    );
  }
}
