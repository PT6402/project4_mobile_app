import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("About us page"),
      ),
    );
  }
}
