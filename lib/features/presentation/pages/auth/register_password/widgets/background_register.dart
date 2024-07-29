import 'package:flutter/widgets.dart';

class BackgroundRegister extends StatelessWidget {
  final Widget child;
  const BackgroundRegister({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [child],
      ),
    );
  }
}
