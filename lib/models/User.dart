import 'dart:convert';

import 'exception.dart';

class User {
  int id;
  String name;
  String username;
  User({
    this.id,
    this.name,
    this.username,
  });

  _validation() {
    if (name == null) {
      throw NullNameException();
    }
  }

  User copyWith({
    int id,
    String name,
    String username,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    _validation();
    return {
      'id': id,
      'name': name,
      'username': username,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      id: map['id'],
      name: map['name'],
      username: map['username'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(id: $id, name: $name, username: $username)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User && o.id == id && o.name == name && o.username == username;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ username.hashCode;
}
