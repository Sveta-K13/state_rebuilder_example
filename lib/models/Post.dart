import 'dart:convert';

import 'exception.dart';

class Post {
  int id;
  int userId;
  String title;
  String body;
  int likes;
  Post({
    this.id,
    this.userId,
    this.title,
    this.body,
    this.likes,
  });

//Entities should contain all the logic it controls
  incrementLikes() {
    likes++;
  }

  _validation() {
    if (userId == null) {
      throw ValidationException('User id can not be undefined');
    }
  }

  Post copyWith({
    int id,
    int userId,
    String title,
    String body,
    int likes,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      likes: likes ?? this.likes,
    );
  }

  Map<String, dynamic> toMap() {
    _validation();
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
      'likes': likes,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Post(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      body: map['body'],
      likes: map['likes'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(id: $id, userId: $userId, title: $title, body: $body, likes: $likes)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Post &&
        o.id == id &&
        o.userId == userId &&
        o.title == title &&
        o.body == body &&
        o.likes == likes;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        title.hashCode ^
        body.hashCode ^
        likes.hashCode;
  }
}
