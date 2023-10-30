import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinder_clone/config/dio.dart';
import 'package:tinder_clone/controllers/account.dart';

enum LikeStatus { like, dislike, superlike, none }

class TinderCardProvider extends ChangeNotifier {
  Offset _position = Offset.zero;
  bool _isSwiping = false;
  Size _screenSize = Size.zero;
  double _rotation = 0.0;

  Offset get position => _position;
  bool get isSwiping => _isSwiping;
  Size get screenSize => _screenSize;
  double get rotation => _rotation;

  void updateScreenSize(Size size) {
    _screenSize = size;
  }

  void startPosition(DragStartDetails details) {
    _isSwiping = true;
    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;
    _rotation = 45 * _position.dx / _screenSize.width;
    notifyListeners();
  }

  void endPosition() {
    _isSwiping = false;
    _rotation = 0.0;
    switch (_getStatus()) {
      case LikeStatus.like:
        like();
        break;
      case LikeStatus.dislike:
        dislike();
        break;
      default:
        resetPosition();
    }
  }

  void resetPosition() {
    _position = Offset.zero;
    _rotation = 0;
    notifyListeners();
  }

  LikeStatus _getStatus() {
    double delta = 100;
    if (position.dx > delta) {
      return LikeStatus.like;
    }
    if (position.dx < -delta) {
      return LikeStatus.dislike;
    }
    return LikeStatus.none;
  }

  void _nextCard() async {
    final accountController = Get.find<AccountController>();
    if (accountController.friends.isEmpty) return;
    await Future.delayed(const Duration(milliseconds: 400));
    accountController.removeLastFriend();
    resetPosition();
  }

  void like({bool isCliked = false}) async {
    final accountController = Get.find<AccountController>();
    _rotation = isCliked ? -35 : 0;
    _position += Offset(2 * screenSize.width, 0);

    // send like request
    try {
      var matched = accountController.friends.last;
      var response = await dio.post("/match", data: {
        "matched_id": matched.id,
      });
      if (response.statusCode == 200) {
        if (response.data["isMatch"]) {
          Get.showSnackbar(
            GetSnackBar(
              onTap: (snack) => {},
              snackPosition: SnackPosition.TOP,
              backgroundGradient: const LinearGradient(
                colors: [
                  Color(0xffb60721),
                  Color(0xffb02742),
                ],
                stops: [0.25, 0.75],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
              snackStyle: SnackStyle.FLOATING,
              margin: const EdgeInsets.all(10),
              borderRadius: 7,
              messageText: ListTile(
                contentPadding: const EdgeInsets.all(5),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    matched.avatar,
                  ),
                ),
                title: const Text(
                  "New Match",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  "Tap to chat with ${matched.name}!",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
      _nextCard();
    } on DioException {
      //
    }
    notifyListeners();
  }

  void dislike({bool isCliked = false}) {
    _rotation = isCliked ? 45 : 0;
    _position += Offset(-2 * screenSize.width, 0);
    _nextCard();
    notifyListeners();
  }
}
