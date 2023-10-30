import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tinder_clone/config/dio.dart';
import 'package:tinder_clone/controllers/register.dart';
import 'package:tinder_clone/data/passions.dart';
import 'package:tinder_clone/pages/register/onboarding/photos.dart';

class GetPassionsScreen extends StatefulWidget {
  const GetPassionsScreen({super.key});

  @override
  State<GetPassionsScreen> createState() => _GetPassionsScreenState();
}

class _GetPassionsScreenState extends State<GetPassionsScreen> {
  final r = Get.find<RegisterController>();
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
                "Passions",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Let others know what you're passionate about. Tinder will prioritize potential matches who share these interests.",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: SingleChildScrollView(
                  child: Expanded(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: passions
                          .map(
                            (interest) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (r.interests.contains(interest)) {
                                    r.interests.remove(interest);
                                  } else if (r.interests.length < 5) {
                                    r.interests.add(interest);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "You can only choose 5 interests",
                                        ),
                                      ),
                                    );
                                  }
                                });
                              },
                              child: AnimatedScale(
                                scale:
                                    r.interests.contains(interest) ? 1.03 : 1,
                                duration: const Duration(milliseconds: 300),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                      color: r.interests.contains(interest)
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey.withOpacity(0.5),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    interest,
                                    style: TextStyle(
                                      color: r.interests.contains(interest)
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey[400],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 10,
        ),
        child: Obx(
          () => SizedBox(
            width: double.infinity,
            height: 50,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: r.interests.length == 5
                    ? const LinearGradient(
                        colors: [Color(0xffef4a75), Color(0xfffd9055)],
                        stops: [0.25, 0.75],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      )
                    : null,
              ),
              child: ElevatedButton(
                onPressed: r.interests.length == 5
                    ? () {
                        registerUser();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  backgroundColor: Colors.transparent,
                ),
                child: Text(
                  "Continue ${r.interests.length}/5",
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  dynamic registerUser() async {
    try {
      var response = await dio.post("/register", data: r.getRegisterData());
      final prefs = SharedPreferences.getInstance();
      prefs.then((value) async {
        await value.setString("token", response.data['token']);
        Get.to(
          () => const GetPhotosScreen(),
          transition: Transition.rightToLeft,
        );
      });
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
        Get.showSnackbar(
          const GetSnackBar(
            backgroundColor: Colors.red,
            message: "An error occured",
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
