import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:statemanegement/blocEx2/views/email_text_field.dart';
import 'package:statemanegement/blocEx2/views/login_button.dart';
import 'package:statemanegement/blocEx2/views/password_text_field.dart';

class LoginView extends HookWidget {
  final OnLoginTapped onLoginTapped;

  const LoginView({required this.onLoginTapped, super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          EmailTextField(emailController: emailController),
          PasswordTextField(passwordController: passwordController),
          LoginButton(
            emailController: emailController,
            passwordController: passwordController,
            onLoginTapped: onLoginTapped,
          ),
        ],
      ),
    );
  }
}
