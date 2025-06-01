import 'package:flutter/material.dart';

import 'nav_bar/google_nav_bar.dart';

class MainHomeView extends StatelessWidget {
  const MainHomeView({super.key});
  static const String routeName = '/mainHome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Container(
            child: Text(
              'Welcome to the Main Home View',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
      ),
    ),
      bottomNavigationBar: GoogleNavBar(),
    );
  }
}

