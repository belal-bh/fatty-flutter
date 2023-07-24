import 'package:fatty_flutter/auth_state.dart';
import 'package:fatty_flutter/models/auth_model.dart';
import 'package:fatty_flutter/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final state = AuthState(await SharedPreferences.getInstance());
  state.checkLoggedIn();

  runApp(MyApp(authState: state));
}

class MyApp extends StatelessWidget {
  final AuthState authState;
  const MyApp({super.key, required this.authState});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthState>(
            lazy: false, create: (BuildContext createContext) => authState),
        ChangeNotifierProvider<AuthFormProvider>(
          lazy: false,
          create: (_) => AuthFormProvider(),
        ),
        Provider<AppRouter>(
          lazy: false,
          create: (BuildContext createContext) => AppRouter(authState),
        ),
      ],
      child: Builder(
        builder: (context) {
          final router = Provider.of<AppRouter>(context, listen: false).router;
          return MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            title: "Fatty Flutter App",
            theme: ThemeData(primarySwatch: Colors.deepPurple),
          );
        },
      ),
    );
  }
}
