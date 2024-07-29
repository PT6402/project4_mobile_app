import 'package:flutter/material.dart';

class MenuBtn extends StatelessWidget {
  final VoidCallback press;
  const MenuBtn({
    super.key,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: press,
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, offset: Offset(0, 3), blurRadius: 8)
              ]),
          child: const Icon(Icons.view_stream),
        ),
      ),
    );
  }
}
