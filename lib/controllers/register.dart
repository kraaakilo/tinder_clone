import 'package:get/get.dart';

class RegisterController extends GetxController {
  final phoneNumber = "".obs;
  final prefixCode = "1".obs;
  final countryCode = "US".obs;
  final email = "".obs;

  final gender = "".obs;
  final showGenderOnProfile = false.obs;

  final dob = "".obs;

  final interests = <String>[].obs;

  final name = "".obs;

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

  void setDob(String value) {
    dob.value = value;
  }

  void setEmail(String value) {
    email.value = value;
  }

  bool canGoToNameStep() {
    return phoneNumber.value.isNotEmpty &&
        phoneNumber.value.length >= 8 &&
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
    data['birthday'] = dob.value;
    data['passions'] = interests.join(',');
    data['name'] = name.value;
    return data;
  }
}
