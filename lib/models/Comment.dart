import 'dart:convert';

import 'package:demo_state_rebuilder/models/values/Email.dart';

import 'exception.dart';

class Comment {
  int id;
  int postId;
  String name;
  //Email is a value object
  Email email;
  String body;
  Comment({
    this.id,
    this.postId,
    this.name,
    this.email,
    this.body,
  });

  _validation() {
    if (postId == null) {
      throw ValidationException('No post is associated with this comment');
    }
  }

  Comment copyWith({
    int id,
    int postId,
    String name,
    Email email,
    String body,
  }) {
    return Comment(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      name: name ?? this.name,
      email: email ?? this.email,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    _validation();
    return {
      'id': id,
      'postId': postId,
      'name': name,
      'email': email?.toMap(),
      'body': body,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Comment(
      id: map['id'],
      postId: map['postId'],
      name: map['name'],
      email: Email(map['email']),
      body: map['body'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comment(id: $id, postId: $postId, name: $name, email: $email, body: $body)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Comment &&
        o.id == id &&
        o.postId == postId &&
        o.name == name &&
        o.email == email &&
        o.body == body;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        postId.hashCode ^
        name.hashCode ^
        email.hashCode ^
        body.hashCode;
  }
}
