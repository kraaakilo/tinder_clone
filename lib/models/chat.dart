class Discussion {
  int? id;
  String? name;
  String? type;
  List<Participants>? participants;
  String? createdAt;
  String? updatedAt;

  Discussion({
    this.id,
    this.name,
    this.type,
    this.participants,
    this.createdAt,
    this.updatedAt,
  });

  Discussion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(Participants.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    if (participants != null) {
      data['participants'] = participants!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Participants {
  int? id;
  String? name;
  String? email;

  Participants({this.name, this.email, this.id});

  Participants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}

class SingleMessageModel {
  int? conversationId;
  int? receiverId;
  String? content;
  bool? isMe;

  SingleMessageModel({
    this.conversationId,
    this.receiverId,
    this.content,
    this.isMe,
  });

  SingleMessageModel.fromJson(Map<String, dynamic> json) {
    conversationId = json['conversation_id'];
    receiverId = json['receiver_id'];
    content = json['content'];
    isMe = json['isMe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['conversation_id'] = conversationId;
    data['receiver_id'] = receiverId;
    data['content'] = content;
    data['isMe'] = isMe;
    return data;
  }
}
