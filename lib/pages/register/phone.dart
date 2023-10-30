import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class GetPhoneScreen extends StatefulWidget {
  const GetPhoneScreen({super.key});

  @override
  State<GetPhoneScreen> createState() => _GetPhoneScreenState();
}

class _GetPhoneScreenState extends State<GetPhoneScreen> {
  String prefixCode = "+1";
  String countryCode = "US";
  String phoneNumber = "";
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
              const Icon(
                Icons.arrow_back_ios,
                size: 25,
                color: Colors.grey,
              ),
              const SizedBox(height: 40),
              const Text(
                "My number is",
                style: TextStyle(
                  fontSize: 30,
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
                            setState(() {
                              prefixCode = country.phoneCode;
                              countryCode = country.countryCode;
                            });
                          },
                        );
                      },
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: "$countryCode +$prefixCode",
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
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
                child: ElevatedButton(
                  onPressed: () {},
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
            ],
          ),
        ),
      ),
    );
  }
}
