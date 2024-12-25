import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: registerController.dob.value,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != registerController.dob.value) {
      registerController.setDob(picked);
    }
  }

  String _formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

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
              GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Obx(
                      () => Text(
                        _formatDate(registerController.dob.value),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 1,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                    ),
                  ],
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
                    onPressed: registerController.dob.value.year < (DateTime.now().year - 18)
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
