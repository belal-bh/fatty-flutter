import 'package:fatty_flutter/auth_state.dart';
import 'package:fatty_flutter/constants.dart';
import 'package:fatty_flutter/models/auth_model.dart';
import 'package:fatty_flutter/widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  late AuthFormProvider _formProvider;

  @override
  Widget build(BuildContext context) {
    _formProvider = Provider.of<AuthFormProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
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
                  hintText: "Type your full name...",
                  labelText: "Name",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
                  ],
                  onChanged: _formProvider.validateName,
                  errorText: _formProvider.name.error,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hintText: "Type email address",
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
                    onPressed: () {
                      if (model.validate) {
                        // model.saveAuthData();
                        // Provider.of<AuthState>(context, listen: false)
                        //     .saveAuthData(
                        //   AuthData(
                        //     name: model.name.value,
                        //     email: model.email.value!,
                        //     password: model.password.value!,
                        //   ),
                        // );
                        context.read<AuthState>().saveAuthData(
                              AuthData(
                                name: model.name.value,
                                email: model.email.value!,
                                password: model.password.value!,
                              ),
                            );
                        context.goNamed(loginRouteName);
                      }
                    },
                    child: const Text('Sign Up'),
                  );
                }),
                TextButton(
                  onPressed: () {
                    context.goNamed(loginRouteName);
                  },
                  child: const Text('Have an account ? Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
