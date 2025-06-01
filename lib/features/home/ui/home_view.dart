import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          'Home View',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Navigate to Profile View
            Navigator.pushNamed(context, '/profile');
          },
          child: const Text('Go to Profile'),
        ),
        ElevatedButton(
          onPressed: () {
            // Navigate to Store View
            Navigator.pushNamed(context, '/store');
          },
          child: const Text('Go to Store'),
        ),
        ElevatedButton(
          onPressed: () {
            // Navigate to Favorite View
            Navigator.pushNamed(context, '/favorite');
          },
          child: const Text('Go to Favorite'),
        ),
      ],
    );
  }
}
