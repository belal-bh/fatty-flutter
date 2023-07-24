import 'package:fatty_flutter/auth_state.dart';
import 'package:fatty_flutter/constants.dart';
import 'package:fatty_flutter/screens/dash.dart';
import 'package:fatty_flutter/screens/error.dart';
import 'package:fatty_flutter/screens/home.dart';
import 'package:fatty_flutter/screens/login.dart';
import 'package:fatty_flutter/screens/profile.dart';
import 'package:fatty_flutter/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

class AppRouter {
  final AuthState authState;
  AppRouter(this.authState);

  late final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    refreshListenable: authState,
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: rootRouteName,
        redirect: (context, state) => state.namedLocation(loginRouteName),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/home',
            name: homeRouteName,
            pageBuilder: (context, state) => MaterialPage(
              child: const HomeScreen(),
              key: state.pageKey,
            ),
          ),
          GoRoute(
            path: '/dash',
            name: dashRouteName,
            pageBuilder: (context, state) => MaterialPage(
              child: const DashScreen(),
              key: state.pageKey,
            ),
          ),
          GoRoute(
            path: '/profile',
            name: profileRouteName,
            pageBuilder: (context, state) => MaterialPage(
              child: const ProfileScreen(),
              key: state.pageKey,
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        name: loginRouteName,
        pageBuilder: (context, state) => MaterialPage(
          child: const LoginScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: '/signup',
        name: signupRouteName,
        pageBuilder: (context, state) => MaterialPage(
          child: const SignupScreen(),
          key: state.pageKey,
        ),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: ErrorScreen(error: state.error),
    ),
    redirect: (BuildContext context, GoRouterState state) {
      final loginLocation = state.namedLocation(loginRouteName);
      final loggingIn = state.matchedLocation == loginLocation;
      final signupLocation = state.namedLocation(signupRouteName);
      final registeringAccount = state.matchedLocation == signupLocation;
      final loggedIn = authState.loggedIn;
      final homelocation = state.namedLocation(homeRouteName);

      if (!loggedIn && !loggingIn && !registeringAccount) {
        return loginLocation;
      }
      if (loggedIn && (loggingIn || registeringAccount)) {
        return homelocation;
      }
      return null;
    },
  );
}

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class ScaffoldWithNavBar extends StatelessWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.child,
    super.key,
  });

  /// The widget to display in the body of the Scaffold.
  /// In this sample, it is a Navigator.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flutter_dash_rounded),
            label: 'Dash',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    if (location.startsWith('/home')) {
      return 0;
    }
    if (location.startsWith('/dash')) {
      return 1;
    }
    if (location.startsWith('/profile')) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/home');
        break;
      case 1:
        GoRouter.of(context).go('/dash');
        break;
      case 2:
        GoRouter.of(context).go('/profile');
        break;
    }
  }
}
