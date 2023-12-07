import 'package:flutter/material.dart';
import 'package:tinder_clone/components/users/chat_app_bar.dart';
import 'package:tinder_clone/components/users/single_message_line.dart';
import 'package:tinder_clone/config/dio.dart';
import 'package:tinder_clone/models/chat.dart';

class SingleChatScreen extends StatefulWidget {
  final int conversationId;
  final int receiverId;
  const SingleChatScreen({
    super.key,
    required this.receiverId,
    required this.conversationId,
  });

  @override
  State<SingleChatScreen> createState() => _SingleChatScreenState();
}

class _SingleChatScreenState extends State<SingleChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  int currentPage = 0;
  List<SingleMessageModel> messages = [];
  @override
  void initState() {
    super.initState();
    _loadMessages();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (!(_scrollController.position.pixels == 0)) {
          setState(() {
            currentPage++;
            _loadMessages(page: currentPage);
          });
          debugPrint("Top");
        } else {
          debugPrint("Bottom");
        }
      }
    });
  }

  Future<void> _loadMessages({int page = 0}) async {
    var response = dio.get("/chats/${widget.conversationId}?page=$page");
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
                controller: _textEditingController,
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Type a message...",
                  suffix: GestureDetector(
                    child: const Text("Send"),
                    onTap: () {
                      if (_textEditingController.text.isNotEmpty) {
                        dio.post("/message", data: {
                          "conversation_id": widget.conversationId,
                          "receiver_id": widget.receiverId,
                          "content": _textEditingController.text,
                        }).catchError((e) {
                          debugPrint(e.toString());
                        });
                        _textEditingController.clear();
                        _loadMessages();
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
