import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class InforCard extends StatelessWidget {
  final String name;
  final String email;
  const InforCard({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(
          IconlyLight.profile,
          color: Colors.white,
        ),
      ),
      title: Text(
        name,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(email, style: const TextStyle(color: Colors.white)),
    );
  }
}
