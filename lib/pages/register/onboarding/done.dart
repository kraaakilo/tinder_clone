import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinder_clone/pages/account/home.dart';

class RegisterDoneScreen extends StatelessWidget {
  const RegisterDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 20,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Want to avoid someone you know on Tinder ?",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "It's easy - share your device's contacts with Tinder when using this feature to pick who you want to avoid.",
                style: TextStyle(
                  fontSize: 17,
                  height: 1.3,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "We'll store your blocked contacts to stop you from seeing each other if your contact has an account with the same info you provide. You can stop sharing contacts with us in your settings.",
                style: TextStyle(
                  fontSize: 17,
                  height: 1.3,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 80,
        ),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                colors: [Color(0xffef4a75), Color(0xfffd9055)],
                stops: [0.25, 0.75],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: ElevatedButton(
              onPressed: () {
                Get.offAll(
                  () => const HomeScreen(),
                  transition: Transition.zoom,
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                backgroundColor: Colors.transparent,
              ),
              child: const Text(
                "Continue",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
