import 'package:fatty_flutter/auth_state.dart';
import 'package:fatty_flutter/constants.dart';
import 'package:fatty_flutter/models/auth_model.dart';
import 'package:fatty_flutter/widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late AuthFormProvider _formProvider;

  @override
  Widget build(BuildContext context) {
    _formProvider = Provider.of<AuthFormProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextFormField(
                  hintText: "email@domain.com",
                  labelText: "Email",
                  onChanged: _formProvider.validateEmail,
                  errorText: _formProvider.email.error,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  obscureText: true,
                  hintText: '',
                  labelText: "Password",
                  onChanged: _formProvider.validatePassword,
                  errorText: _formProvider.password.error,
                ),
                const SizedBox(height: 24),
                Consumer<AuthFormProvider>(
                    builder: (contextConsumer, model, child) {
                  return ElevatedButton(
                    onPressed: () async {
                      if (model.validate) {
                        debugPrint("Validation pass...");
                        bool isValidCredential = await contextConsumer
                            .read<AuthState>()
                            .isValidCredential(
                              model.email.value!,
                              model.password.value!,
                            );
                        if (isValidCredential) {
                          debugPrint("Setting login success...");
                          // ignore: use_build_context_synchronously
                          contextConsumer.read<AuthState>().loggedIn = true;
                          // ignore: use_build_context_synchronously
                          contextConsumer.goNamed(loginRouteName);
                        } else {
                          debugPrint("Invalid Credential...");
                          // ignore: use_build_context_synchronously
                          contextConsumer
                              .read<AuthState>()
                              .showInvalidCredentialsSnackbar(contextConsumer);
                        }
                      }
                      debugPrint("Validation failed...");
                    },
                    child: const Text('Login'),
                  );
                }),
                TextButton(
                  onPressed: () {
                    // Navigate to signup screen
                    context.goNamed(signupRouteName);
                  },
                  child: const Text('Create an account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
