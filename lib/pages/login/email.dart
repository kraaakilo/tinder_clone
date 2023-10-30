import 'package:flutter/material.dart';
import 'package:tinder_clone/config/dio.dart';
import 'package:tinder_clone/controllers/login.dart';
import 'package:get/get.dart';
import 'package:tinder_clone/pages/login/otp.dart';

class GetEmailForLoginScreen extends StatefulWidget {
  const GetEmailForLoginScreen({super.key});

  @override
  State<GetEmailForLoginScreen> createState() => _GetEmailForLoginScreenState();
}

class _GetEmailForLoginScreenState extends State<GetEmailForLoginScreen> {
  final loginController = Get.find<LoginController>();
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
                "Type your email",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Obx(
                () => TextFormField(
                  initialValue: loginController.email.value,
                  onChanged: (value) {
                    loginController.setEmail(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Email",
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
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: loginController.email.value.isEmail
                        ? () async {
                            dio.get(
                              "/get-otp",
                              queryParameters: {
                                "email": loginController.email.value,
                              },
                            ).then((value) {
                              Get.to(
                                () => const GetOTPScreen(),
                                transition: Transition.rightToLeft,
                              );
                            }).catchError((onError) {
                              debugPrint(onError.toString());
                              Get.snackbar(
                                "Error",
                                "Something went wrong with your email.",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            });
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
}
