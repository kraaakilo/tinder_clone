import 'package:flutter/material.dart';

class EmptyChat extends StatefulWidget {
  const EmptyChat({super.key});

  @override
  State<EmptyChat> createState() => _EmptyChatState();
}

class _EmptyChatState extends State<EmptyChat> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Center(
            child: Text(
              "You matched with Kraaakilo.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "3 days ago",
        ),
        const SizedBox(
          height: 20,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(180.0),
          child: Image.network(
            "https://i.pravatar.cc/150",
            height: 180,
            width: 180,
            fit: BoxFit.cover,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          child: SizedBox(
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Type a message...",
                suffix: const Text("Send"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
