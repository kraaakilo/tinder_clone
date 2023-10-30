import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tinder_clone/config/dio.dart';
import 'package:tinder_clone/models/user.dart';

class AccountController extends GetxController {
  var friends = <UserModel>[].obs;
  var authUser = UserModel.empty().obs;

  void setFriends(List<UserModel> newFriends) {
    friends.value = newFriends;
  }

  void removeLastFriend() {
    debugPrint("removing last friend");
    friends.removeLast();
  }

  void setUser(UserModel user) {
    authUser.value = user;
  }
}

Future<dynamic> getAuthToken() async {
  final prefs = await SharedPreferences.getInstance();
  try {
    return dio.get("/me");
  } on DioException {
    prefs.remove("token");
  } catch (e) {
    debugPrint(e.toString());
  }
  return null;
}
