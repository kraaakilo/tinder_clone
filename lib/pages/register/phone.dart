import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:tinder_clone/controllers/register.dart';
import 'package:get/get.dart';
import 'package:tinder_clone/pages/register/onboarding/email.dart';

class GetPhoneScreen extends StatefulWidget {
  const GetPhoneScreen({super.key});

  @override
  State<GetPhoneScreen> createState() => _GetPhoneScreenState();
}

class _GetPhoneScreenState extends State<GetPhoneScreen> {
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
                "My number is",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          showSearch: false,
                          countryListTheme: const CountryListThemeData(
                            flagSize: 25,
                            backgroundColor: Colors.white,
                            textStyle: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          onSelect: (Country country) {
                            r.setCountryCode(country.countryCode);
                            r.setPrefixCode(country.phoneCode);
                          },
                        );
                      },
                      child: Obx(
                        () => TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: "${r.countryCode} +${r.prefixCode}",
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => TextFormField(
                        onChanged: (value) {
                          r.setPhoneNumber(value);
                        },
                        initialValue: r.phoneNumber.value,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFf3606e),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "When you tap Continue, Tinder will send a text with verification code. "
                "Message and data rates may apply. The verified phone number can be used "
                "to log in. Learn what happens when your number changes.",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: r.canGoToNameStep()
                        ? () {
                            Get.to(
                              () => const GetEmailScreen(),
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
                      "Send",
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
