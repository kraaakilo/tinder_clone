import 'package:flutter/material.dart';
import 'package:tinder_clone/controllers/register.dart';
import 'package:get/get.dart';
import 'package:tinder_clone/pages/register/onboarding/passions.dart';

class GetBirthScreen extends StatefulWidget {
  const GetBirthScreen({super.key});

  @override
  State<GetBirthScreen> createState() => _GetBirthScreenState();
}

class _GetBirthScreenState extends State<GetBirthScreen> {
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
                "My birthday is",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    registerController.setDob("value");
                  },
                  child: TextFormField(
                    initialValue: registerController.dob.value,
                    enabled: true,
                    onChanged: (value) {
                      registerController.setDob(value);
                    },
                    decoration: const InputDecoration(
                      hintText: "DD / MM / YYYY",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFf3606e),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Your age will be public.",
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
                    onPressed: registerController.name.value.isNotEmpty
                        ? () {
                            FocusScope.of(context).unfocus();
                            Get.to(
                              () => const GetPassionsScreen(),
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
}
