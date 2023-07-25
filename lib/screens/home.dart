import 'package:fatty_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Fatty Flutter!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement the logic to navigate to the Dash Screen
                context.goNamed(dashRouteName);
              },
              child: const Text('Go to Dash Screen'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement the logic to navigate to the Dash Screen
                context.goNamed(homeAboutRouteName);
              },
              child: const Text('Go to About Screen'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Implement the logic to navigate to the Profile Screen
                context.goNamed(profileRouteName);
              },
              child: const Text('Go to Profile Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
