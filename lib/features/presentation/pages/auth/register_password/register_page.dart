import 'package:flutter/material.dart';
import 'package:testtem/features/presentation/pages/auth/register_password/widgets/body_register.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const BodyRegister(),
    );
  }
}
