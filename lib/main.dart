import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tinder_clone/card_model.dart';
import 'package:tinder_clone/tinder_card.dart';
import 'package:tinder_clone/tinder_card_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TinderCardProvider(),
      child: const MaterialApp(
        title: "Tinder Clone",
        home: App(),
      ),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          "assets/images/logo.png",
          height: 40,
        ),
        centerTitle: true,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://avatars.githubusercontent.com/u/139426?s=400&u=8e7b6e6d0b9e9b0b0b0b0b0b0b0b0b0b0b0b0b0b&v=4",
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.grey,
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: Provider.of<TinderCardProvider>(context)
              .cards
              .map(
                (e) => TinderCard(
                  isFront:
                      Provider.of<TinderCardProvider>(context).cards.last == e,
                  cardModel: chuckNorris,
                ),
              )
              .toList(),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/icon.png",
                height: 35,
              ),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/star.svg",
                semanticsLabel: 'A red up arrow',
                height: 35,
              ),
              label: "Chats",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_outlined),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/message.svg",
                semanticsLabel: 'A red up arrow',
                height: 35,
              ),
              label: "Profiles",
            ),
          ],
        ),
      ),
    );
  }
}
