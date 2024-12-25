import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final phoneNumber = "00000000".obs;
  final prefixCode = "1".obs;
  final countryCode = "US".obs;
  final email = "kraaakilo@m3a.site".obs;

  final gender = "".obs;
  final showGenderOnProfile = false.obs;

  final dob = DateTime.now().obs;

  final interests = <String>[].obs;

  final name = "Mr TripleA".obs;

  void setPhoneNumber(String value) {
    phoneNumber.value = value;
  }

  void setPrefixCode(String value) {
    prefixCode.value = value;
  }

  void setCountryCode(String value) {
    countryCode.value = value;
  }

  void setName(String value) {
    name.value = value;
  }

  void addInterest(String value) {
    interests.add(value);
  }

  void removeInterest(String value) {
    interests.remove(value);
  }

  void setGender(String value) {
    gender.value = value;
  }

  void setShowGenderOnProfile(bool value) {
    showGenderOnProfile.value = value;
  }

  void setDob(DateTime value) {
    dob.value = value;
  }

  void setEmail(String value) {
    email.value = value;
  }

  bool canGoToNameStep() {
    final RegExp numberRegExp = RegExp(r'^\d+(\.\d+)?$');
    return phoneNumber.value.isNotEmpty &&
        phoneNumber.value.length >= 8 &&
        numberRegExp.hasMatch(phoneNumber.value) &&
        prefixCode.value.isNotEmpty &&
        countryCode.value.isNotEmpty;
  }

  Map<String, String> getRegisterData() {
    var data = <String, String>{};
    data['phone'] = prefixCode.value + phoneNumber.value;
    data['country'] = countryCode.value;
    data['email'] = email.value;
    data['gender'] = gender.value;
    data['showGenderOnProfile'] = showGenderOnProfile.value.toString();
    data['birthday'] = dob.toString();
    data['passions'] = interests.join(',');
    data['name'] = name.value;
    return data;
  }
}
