import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordLogin extends StatelessWidget {
  const ForgotPasswordLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Spacer(),
          GestureDetector(
            onTap: () => context.pushNamed("forgotPassword"),
            child: const Text(
              "Forgot Password",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
          )
        ],
      ),
    );
  }
}
