import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tinder_clone/config/dio.dart';
import 'package:tinder_clone/controllers/account.dart';
import 'package:tinder_clone/controllers/login.dart';
import 'package:tinder_clone/models/user.dart';
import 'package:tinder_clone/pages/account/home.dart';

class GetOTPScreen extends StatefulWidget {
  const GetOTPScreen({super.key});

  @override
  State<GetOTPScreen> createState() => GetOTPScreenState();
}

class GetOTPScreenState extends State<GetOTPScreen> {
  final loginController = Get.find<LoginController>();
  final OtpFieldController _fieldController = OtpFieldController();
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
                "Enter the code sent to your email",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              OTPTextField(
                length: 5,
                controller: _fieldController,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 40,
                style: const TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onChanged: (value) {
                  loginController.setPin(value);
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Go back to resend a new code.",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint(loginController.pin.value);
                    dio.get(
                      "/check-otp",
                      queryParameters: {
                        "email": loginController.email.value,
                        "otp": loginController.pin.value,
                      },
                    ).then((value) async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString("token", value.data["token"]);
                      final acc = Get.find<AccountController>();
                      acc.setUser(UserModel.fromJson(value.data["user"]));
                      dio.options.headers["Authorization"] =
                          "Bearer ${value.data["token"]}";
                      Get.to(
                        () => const HomeScreen(),
                        transition: Transition.zoom,
                        duration: const Duration(milliseconds: 500),
                      );
                    }).catchError((onError) {
                      _fieldController.clear();
                      debugPrint(onError.toString() + "*" * 100);
                      Get.snackbar(
                        "Error",
                        "Wrong Code",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    });
                  },
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
            ],
          ),
        ),
      ),
    );
  }
}
