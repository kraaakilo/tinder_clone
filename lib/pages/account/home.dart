import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tinder_clone/components/tinder_card.dart';
import 'package:tinder_clone/components/users/app_bar.dart';
import 'package:tinder_clone/components/users/bottom_bar.dart';
import 'package:tinder_clone/config/dio.dart';
import 'package:tinder_clone/controllers/account.dart';
import 'package:tinder_clone/models/user.dart';
import 'package:tinder_clone/pages/start_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final accountController = Get.find<AccountController>();
  @override
  void initState() {
    super.initState();
    _getFriends();
  }

  void _getFriends() async {
    var response = await dio.get("/feed");
    List<UserModel> parsedFriends = [];
    for (var friend in response.data) {
      parsedFriends.add(UserModel.fromJson(friend));
    }
    accountController.setFriends(parsedFriends);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text(accountController.authUser.value.name),
              onTap: null,
            ),
            ListTile(
              title: const Text("Logout"),
              onTap: () async {
                Get.offAll(() => const StartScreen());
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Obx(
          () => Stack(
            children: [
              SizedBox(
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _getFriends();
                    },
                    child: const Text("Get Friends"),
                  ),
                ),
              ),
              ...accountController.friends
                  .map(
                    (friend) => TinderCard(
                      isFront: accountController.friends.last == friend,
                      user: friend,
                    ),
                  )
                  .toList()
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
