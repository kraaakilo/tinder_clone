import 'package:flutter/material.dart';
import 'package:tinder_clone/components/users/chat_app_bar.dart';
import 'package:tinder_clone/components/users/single_message_line.dart';
import 'package:tinder_clone/config/dio.dart';
import 'package:tinder_clone/models/chat.dart';

class SingleChatScreen extends StatefulWidget {
  final int conversationId;
  const SingleChatScreen({super.key, required this.conversationId});

  @override
  State<SingleChatScreen> createState() => _SingleChatScreenState();
}

class _SingleChatScreenState extends State<SingleChatScreen> {
  final ScrollController _scrollController = ScrollController();
  List<SingleMessageModel> messages = [];
  @override
  void initState() {
    super.initState();
    _loadMessages();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          debugPrint("Top");
        } else {
          debugPrint("Bottom");
        }
      }
    });
  }

  Future<void> _loadMessages() async {
    var response = dio.get("/chats/${widget.conversationId}");
    List<SingleMessageModel> array = (await response)
        .data["data"]
        .map<SingleMessageModel>((e) => SingleMessageModel.fromJson(e))
        .toList();
    setState(() {
      messages = array;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: true,
              physics: const BouncingScrollPhysics(),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return SingleMessageLine(
                  isMe: messages[index].isMe!,
                  message: messages[index].content!,
                );
              },
            ),
          ),
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
      ),
    );
  }
}
