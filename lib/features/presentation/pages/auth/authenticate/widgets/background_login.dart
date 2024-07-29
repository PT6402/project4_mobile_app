import 'package:flutter/material.dart';

class BackgroundLogin extends StatelessWidget {
  final Widget child;
  const BackgroundLogin({super.key, required this.child});

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
