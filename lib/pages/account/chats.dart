import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinder_clone/components/users/app_bar.dart';
import 'package:tinder_clone/components/users/bottom_bar.dart';
import 'package:tinder_clone/config/dio.dart';
import 'package:tinder_clone/models/chat.dart';
import 'package:tinder_clone/pages/account/single_chat.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  List<Discussion> discussions = [];

  @override
  void initState() {
    super.initState();
    _loadDiscussions();
  }

  Future<void> _loadDiscussions() async {
    var response = dio.get("/chats");
    List<Discussion> array = (await response)
        .data["data"]
        .map<Discussion>((e) => Discussion.fromJson(e))
        .toList();
    setState(() {
      discussions = array;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BottomBar(),
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                title: CustomAppBar(),
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                toolbarHeight: 70,
                floating: true,
              ),
            ],
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Search 4 matches",
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 30,
                  ),
                  Text(
                    "Messages",
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: discussions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Get.to(
                              () => SingleChatScreen(
                                conversationId: discussions[index].id!,
                              ),
                              transition: Transition.cupertino,
                              duration: const Duration(milliseconds: 500),
                            );
                          },
                          onLongPress: () {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                ),
                              ),
                              builder: (context) => Column(
                                children: [
                                  const Divider(
                                    height: 30,
                                    thickness: 5,
                                    indent: 150,
                                    endIndent: 150,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          onTap: () {
                                            Get.back();
                                          },
                                          leading: const Icon(Icons.delete),
                                          title: const Text("Delete"),
                                        ),
                                        const ListTile(
                                          leading: Icon(Icons.block),
                                          title: Text("Block"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://i.pravatar.cc/150?img=${index.toString()}",
                            ),
                          ),
                          title: Text(
                            discussions[index].participants![0].name!,
                          ),
                          subtitle: const Text("..."),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.shield,
            color: Colors.blue,
          ),
        ));
  }
}
