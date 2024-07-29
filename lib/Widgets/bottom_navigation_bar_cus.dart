import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class BottomNavigationBarCus extends StatelessWidget {
  final int selectedIndex;
  final dynamic onTap;

  const BottomNavigationBarCus(
      {super.key, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      // color: AppColor.gray50.withOpacity(0.2),
      notchMargin: 10,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _bottomAppBarItem(context,
                icon: IconlyLight.home, page: 0, label: "Home"),
            _bottomAppBarItem(context,
                icon: IconlyLight.heart, page: 1, label: "Wishlist"),
            _bottomAppBarItem(context,
                icon: IconlyLight.profile, page: 2, label: "Account"),
          ],
        ),
      ),
    );
  }

  Widget _bottomAppBarItem(BuildContext context,
      {required icon, required page, required label}) {
    return ZoomTapAnimation(
        onTap: () => onTap(page),
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: selectedIndex == page ? Colors.blueGrey : Colors.grey,
              ),
              Text(
                label,
                style: TextStyle(
                    color:
                        selectedIndex == page ? Colors.blueGrey : Colors.grey,
                    fontSize: 13,
                    fontWeight: selectedIndex == page ? FontWeight.w600 : null),
              )
            ],
          ),
        ));
  }
}
