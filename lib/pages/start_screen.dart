import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinder_clone/controllers/login.dart';
import 'package:tinder_clone/pages/login/email.dart';
import 'package:tinder_clone/pages/register/phone.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.maxFinite,
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage("assets/images/icon.png"),
                    height: 60,
                  ),
                  // animate the text width and opacity
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: 1,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      child: const Text(
                        "tinder",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 45,
                    vertical: 16,
                  ),
                  child: Text(
                    "By tapping create an account or login, you agree to our Terms. Learn how we process your data in our Privacy Policy and Cookies Policy.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(
                          const GetPhoneScreen(),
                          transition: Transition.zoom,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        backgroundColor: const Color(0xFFf3606e),
                      ),
                      child: const Text(
                        "CREATE ACCOUNT",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.lazyPut(() => LoginController());
                        Get.to(
                          () => const GetEmailForLoginScreen(),
                          transition: Transition.zoom,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: const BorderSide(
                            color: Color(0xFFf3606e),
                            width: 0.6,
                          ),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        "SIGN IN",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFFf3606e),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          )
        ],
      ),
    );
  }
}
