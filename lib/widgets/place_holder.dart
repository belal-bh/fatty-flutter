import 'package:fatty_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlaceHolder extends StatelessWidget {
  final String title;
  final String text;
  final String? navigateTo;
  const PlaceHolder(
      {super.key, required this.title, required this.text, this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement the logic to navigate back to the Home Screen
                context.goNamed(homeRouteName);
              },
              child: const Text('Go Back to Home'),
            ),
            if (navigateTo != null)
              ElevatedButton(
                onPressed: () {
                  // Implement the logic to navigate back to the Home Screen
                  context.goNamed(navigateTo!);
                },
                child: Text('Navigate to ${navigateTo ?? "..."}'),
              ),
          ],
        ),
      ),
    );
  }
}
