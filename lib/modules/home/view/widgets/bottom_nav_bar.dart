import 'package:flutter/material.dart';
import 'package:my_project_new/constant/app_colors.dart';
import 'package:my_project_new/constant/images.dart';
import 'package:my_project_new/modules/home/view/screens/bottom_nav_screen.dart';
import 'package:my_project_new/modules/home/view/screens/home_screen.dart';
import 'package:my_project_new/modules/home/view/widgets/nav_button.dart';
import 'package:my_project_new/widgets/bottom_nav_package/curved_navigation_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.onChange});
  final void Function(int index) onChange;
  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  final List icons = [
    {"title": "sections", "icon": Images.sectoins, "screen": Container()},
    {"title": "home", "icon": Images.home, "screen": const HomeScreen()},
    {"title": "more", "icon": Images.more, "screen": Container()},
  ];

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      color: AppColors.SECONDRY,
      buttonBackgroundColor: const Color.fromARGB(255, 243, 243, 243),
      index: selectedPage.value,
      items: List.generate(
        icons.length,
        (index) {
          return NavButton(
            icons: icons,
            page: selectedPage.value,
            index: index,
          );
        },
      ),
      onTap: (index) {
        if (selectedPage.value != index) {
          widget.onChange(index);
          setState(() {});
        }
      },
    );
  }
}
