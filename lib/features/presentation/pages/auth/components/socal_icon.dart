import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocalIcon extends StatelessWidget {
  final String iconSrc;
  final dynamic press;
  const SocalIcon({
    super.key,
    required this.iconSrc,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey, width: 2),
            shape: BoxShape.circle),
        child: SvgPicture.asset(
          iconSrc,
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}
