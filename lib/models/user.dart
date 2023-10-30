class UserModel {
  int id = 0;
  String name = "";
  String gender = "";
  String country = "";
  String birthday = "";
  String avatar = "";
  int age = 0;
  List<String> photos = [];
  List<String> passions = [];

  UserModel.empty();
  UserModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.country,
    required this.birthday,
    required this.avatar,
    required this.age,
    required this.photos,
    required this.passions,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    country = json['country'];
    birthday = json['birthday'];
    avatar = json['avatar'];
    age = json['age'];
    photos = json['photos'].cast<String>();
    passions = json['passions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['gender'] = gender;
    data['country'] = country;
    data['birthday'] = birthday;
    data['avatar'] = avatar;
    data['age'] = age;
    data['photos'] = photos;
    data['passions'] = passions;
    return data;
  }
}
