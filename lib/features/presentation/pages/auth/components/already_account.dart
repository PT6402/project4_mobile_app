import 'package:flutter/material.dart';

class AlreadyAccount extends StatelessWidget {
  final bool login;
  final dynamic press;
  const AlreadyAccount({
    super.key,
    this.login = true,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? "Don't have an account ? " : "Already account ? ",
          style: const TextStyle(color: Colors.blueGrey),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign up" : "Login",
            style: const TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blueGrey),
          ),
        )
      ],
    );
  }
}
