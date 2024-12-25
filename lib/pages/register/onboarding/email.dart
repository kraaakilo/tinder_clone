import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tinder_clone/controllers/register.dart';
import 'package:get/get.dart';
import 'package:tinder_clone/pages/register/onboarding/name.dart';
import 'package:tinder_clone/config/dio.dart';

class GetEmailScreen extends StatefulWidget {
  const GetEmailScreen({super.key});

  @override
  State<GetEmailScreen> createState() => _GetEmailScreenState();
}

class _GetEmailScreenState extends State<GetEmailScreen> {
  final registerController = Get.find<RegisterController>();

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
                "Type your email to get started.",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Obx(
                () => TextFormField(
                  initialValue: registerController.email.value,
                  onChanged: (value) {
                    registerController.setEmail(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Email Address",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.name,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "This won't be shown publicly. Confirm your email later.",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: registerController.email.value.isEmail
                        ? () async {
                            var r = await _checkIsUsedEmail(
                                registerController.email.value);
                            if (r) {
                              Get.showSnackbar(
                                const GetSnackBar(
                                  backgroundColor: Colors.red,
                                  message: "The email is already in use.",
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              Get.to(
                                () => const GetNameScreen(),
                                transition: Transition.rightToLeft,
                              );
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      backgroundColor: const Color(0xFFf3606e),
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
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _checkIsUsedEmail(String email) async {
    try {
      await dio.get(
        "/register/email-check",
        queryParameters: {'email': email},
      );
      return true;
    } on DioException catch (e) {
      return false;
    }
  }
}
