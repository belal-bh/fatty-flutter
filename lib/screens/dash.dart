import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashScreen extends StatelessWidget {
  const DashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Dash...");
    return Scaffold(
      appBar: AppBar(title: const Text('Dash')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Dash Screen!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement the logic to navigate back to the Home Screen
                // context.goNamed(homeRouteName);
                context.go('/kdkfjgd');
              },
              child: const Text('Back to Home Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
