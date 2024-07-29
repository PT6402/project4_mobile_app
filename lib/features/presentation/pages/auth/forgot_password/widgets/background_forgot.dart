import 'package:flutter/material.dart';

class BackgroundForgot extends StatelessWidget {
  final Widget child;
  const BackgroundForgot({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [child],
        ),
      ),
    );
  }
}
