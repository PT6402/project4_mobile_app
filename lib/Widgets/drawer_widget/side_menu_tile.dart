import 'package:flutter/material.dart';

class SideMenuTile extends StatelessWidget {
  final String name;
  final IconData icon;
  final VoidCallback press;
  final bool isActive;
  const SideMenuTile({
    super.key,
    required this.name,
    required this.icon,
    required this.press,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24, right: 24),
          child: Divider(
            color: Colors.black45,
            height: 1,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              height: 56,
              width: isActive ? 288 : 0,
              left: 0,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            ListTile(
              onTap: press,
              leading: SizedBox(
                height: 34,
                width: 34,
                child: Icon(
                  icon,
                  color: Colors.black,
                ),
              ),
              title: Text(
                name,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
