import 'package:flutter/material.dart';
import 'package:testtem/features/presentation/pages/auth/authenticate/widgets/body_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BodyLogin(),
    );
  }
}
