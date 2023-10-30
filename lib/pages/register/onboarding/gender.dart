import 'package:flutter/material.dart';

class GetNameScreen extends StatefulWidget {
  const GetNameScreen({super.key});

  @override
  State<GetNameScreen> createState() => _GetNameScreenState();
}

class _GetNameScreenState extends State<GetNameScreen> {
  String name = "";
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
                "My name is",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Name",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFf3606e),
                    ),
                  ),
                ),
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20),
              const Text(
                "This is how it will appear in Tinder, and it can't be changed later.",
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
                  onPressed: () {},
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
