import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinder_clone/controllers/account.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(90);
  final accountController = Get.find<AccountController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              borderRadius: BorderRadius.circular(25.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      accountController.authUser.value.avatar,
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ),
            Image.asset(
              "assets/images/logo.png",
              height: 50,
            ),
            IconButton(
              icon: const Icon(
                Icons.notifications,
                color: Colors.grey,
                size: 30,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
