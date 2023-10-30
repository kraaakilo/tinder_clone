import 'package:flutter/material.dart';
import 'package:tinder_clone/controllers/register.dart';
import 'package:get/get.dart';
import 'package:tinder_clone/pages/register/onboarding/name.dart';

class GetEmailScreen extends StatefulWidget {
  const GetEmailScreen({super.key});

  @override
  State<GetEmailScreen> createState() => _GetEmailScreenState();
}

class _GetEmailScreenState extends State<GetEmailScreen> {
  final registerController = Get.find<RegisterController>();
  bool isUsedEmail = false;
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
                  initialValue: registerController.name.value,
                  onChanged: (value) {
                    setState(() {
                      isUsedEmail = false;
                    });
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
              isUsedEmail
                  ? const Text(
                      "Email already in use.",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(height: 12),
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
                    onPressed: registerController.email.value.isNotEmpty
                        ? () async {
                            isUsedEmail = await _checkIsUsedEmail(
                                registerController.email.value);
                            if (isUsedEmail) {
                              setState(() {
                                isUsedEmail = true;
                              });
                              return;
                            }
                            Get.to(
                              () => const GetNameScreen(),
                              transition: Transition.rightToLeft,
                            );
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
    await Future.delayed(const Duration(milliseconds: 200));
    return false;
  }
}
