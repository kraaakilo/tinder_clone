import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tinder_clone/pages/account/chats.dart';
import 'package:tinder_clone/pages/account/home.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Get.to(() => const HomeScreen());
              },
              child: Image.asset(
                "assets/images/icon.png",
                height: 35,
              ),
            ),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Get.to(() => const ChatsScreen());
              },
              child: const Icon(Icons.messenger),
            ),
            label: "Profiles",
          ),
        ],
      ),
    );
  }
}
