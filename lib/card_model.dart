class CardModel {
  String? name;
  int? age;
  double? distance;
  List<String> interests = [];
  List<String> photos = [];

  CardModel(
      {this.name,
      this.age,
      this.distance,
      required this.interests,
      required this.photos});

  CardModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    distance = json['distance'];
    interests = json['interests'].cast<String>();
    photos = json['photos'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['age'] = age;
    json['distance'] = distance;
    json['interests'] = interests;
    json['photos'] = photos;
    return json;
  }
}

CardModel chuckNorris =
    CardModel(name: 'Chuck Norris', age: 81, distance: 0.5, interests: [
  'Karate',
  'Guns',
  'Martial Arts'
], photos: [
  'https://upload.wikimedia.org/wikipedia/commons/7/7e/Cardi_B_2021_02.jpg',
]);
