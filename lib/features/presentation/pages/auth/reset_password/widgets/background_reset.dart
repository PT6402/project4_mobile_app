import 'package:flutter/material.dart';

class BackgroundReset extends StatelessWidget {
  final Widget child;
  const BackgroundReset({super.key, required this.child});

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
