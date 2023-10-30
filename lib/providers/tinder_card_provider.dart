import 'package:flutter/material.dart';

class TinderCardProvider extends ChangeNotifier {
  Offset _position = Offset.zero;
  bool _isSwiping = false;
  Size _screenSize = Size.zero;
  double _rotation = 0.0;

  List<String> _cards = [
    "https://upload.wikimedia.org/wikipedia/commons/7/7e/Cardi_B_2021_02.jpg",
    "https://cdn.britannica.com/85/229185-050-3CC1C44E/Cardi-B-2019.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/7/7e/Cardi_B_2021_02.jpg",
    "https://cdn.britannica.com/85/229185-050-3CC1C44E/Cardi-B-2019.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/7/7e/Cardi_B_2021_02.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/7/7e/Cardi_B_2021_02.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/7/7e/Cardi_B_2021_02.jpg",
  ];

  List<String> get cards => _cards;

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
    resetPosition();
  }

  void resetPosition() {
    _position = Offset.zero;
    _rotation = 20;
    _position += Offset(2 * screenSize.width, 0);
    _cards.removeLast();
    notifyListeners();
  }
}
