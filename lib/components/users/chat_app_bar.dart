import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      elevation: 1.6,
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.grey,
        ),
      ),
      title: Column(
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Kraaakilo",
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 12,
            ),
          ),
        ],
      ),
      actions: const [
        Icon(
          Icons.videocam,
          color: Colors.blue,
          size: 30,
        ),
        SizedBox(
          width: 12,
        ),
        Icon(
          Icons.shield,
          color: Colors.blue,
        ),
        SizedBox(
          width: 15,
        ),
      ],
      centerTitle: true,
    );
  }
}
