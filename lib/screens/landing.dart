import 'package:fatty_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingSceen extends StatelessWidget {
  const LandingSceen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(bottom: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/fatty_flutter_transparent.png', // Replace with your image path
                  // width: 400,
                  // height: 400,
                  colorBlendMode: BlendMode.dstOut,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Welcome to Fatty Flutter!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'A simple and powerful Flutter app.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Implement the logic to navigate to the Sign-In screen
                        context.goNamed(loginRouteName);
                      },
                      child: const Text('Login'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Implement the logic to navigate to the Sign-Up screen
                        context.goNamed(signupRouteName);
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
