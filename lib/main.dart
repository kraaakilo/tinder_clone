import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tinder_clone/config/dio.dart';
import 'package:tinder_clone/config/theme.dart';
import 'package:tinder_clone/controllers/account.dart';
import 'package:tinder_clone/controllers/register.dart';
import 'package:tinder_clone/models/user.dart';
import 'package:tinder_clone/pages/account/chats.dart';
import 'package:tinder_clone/pages/start_screen.dart';
import 'package:tinder_clone/providers/tinder_card_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthInterceptor.init();
  runApp(
    ChangeNotifierProvider(
      create: (context) => TinderCardProvider(),
      child: GetMaterialApp(
        theme: buildTheme(const ColorScheme.light()),
        debugShowCheckedModeBanner: false,
        title: "Tinder Clone",
        home: const App(),
      ),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AccountController());
    return FutureBuilder(
      future: getAuthToken(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {}
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          final acc = Get.find<AccountController>();
          acc.setUser(UserModel.fromJson(snapshot.data.data));
          return const ChatsScreen();
        } else {
          Get.lazyPut(() => RegisterController());
          return const StartScreen();
        }
      },
    );
  }
}
