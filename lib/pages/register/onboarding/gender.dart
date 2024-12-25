import 'package:flutter/material.dart';
import 'package:tinder_clone/controllers/register.dart';
import 'package:get/get.dart';
import 'package:tinder_clone/pages/register/onboarding/birthday.dart';

class GetGenderScreen extends StatefulWidget {
  const GetGenderScreen({super.key});

  @override
  State<GetGenderScreen> createState() => _GetGenderScreenState();
}

class _GetGenderScreenState extends State<GetGenderScreen> {
  final registerController = Get.find<RegisterController>();
  final List<String> _genders = [
    "MAN",
    "WOMAN",
  ];

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
                "I am a",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              Column(
                children: _genders
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          if (registerController.gender.value == e) {
                            registerController.setGender("");
                          } else {
                            registerController.setGender(e);
                          }
                        },
                        child: Obx(
                          () => Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(
                              bottom: 15,
                            ),
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: e == registerController.gender.value
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey.withValues(alpha: 0.4),
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                e,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: e == registerController.gender.value
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey,
                                  fontWeight:
                                      e == registerController.gender.value
                                          ? FontWeight.w900
                                          : null,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const Spacer(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Checkbox(
                      value: registerController.showGenderOnProfile.value,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (bool? value) {
                        registerController.setShowGenderOnProfile(value!);
                      },
                    ),
                  ),
                  const Text(
                    "Show gender on my profile",
                  ),
                ],
              ),
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: registerController.gender.isEmpty
                          ? null
                          : const LinearGradient(
                              colors: [Color(0xffef4a75), Color(0xfffd9055)],
                              stops: [0.25, 0.75],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                    ),
                    child: ElevatedButton(
                      onPressed: registerController.gender.isEmpty
                          ? null
                          : () {
                              Get.to(
                                () => const GetBirthScreen(),
                                transition: Transition.rightToLeft,
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
                        "CONTINUE",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
