import 'dart:convert';

import 'package:demo_state_rebuilder/models/Comment.dart';
import 'package:demo_state_rebuilder/models/Post.dart';
import 'package:demo_state_rebuilder/models/User.dart';

import 'exceptions.dart';
import 'interface.dart';
import 'package:http/http.dart' as http;

class Api implements IApi, IApiUser {
  static const endpoint = 'https://jsonplaceholder.typicode.com';
  var client = http.Client();

  Future<User> getUserProfile(int userId) async {
    var response;
    try {
      response = await client.get('$endpoint/users/$userId');
    } catch (e) {
      //Handle network error
      //It must throw custom errors classes defined in the service layer
      throw NetworkErrorException();
    }
    //Handle not found page
    if (response.statusCode == 404) {
      throw UserNotFoundException(userId);
    }
    return User.fromJson(response.body);
  }

  Future<List<Post>> getPostsForUser(int userId) async {
    var posts = <Post>[];
    var response;
    try {
      response = await client.get('$endpoint/posts?userId=$userId');
    } catch (e) {
      throw NetworkErrorException();
    }
    if (response.statusCode == 404) {
      throw PostNotFoundException(userId);
    }
    var parsed = json.decode(response.body) as List<dynamic>;
    for (var post in parsed) {
      posts.add(Post.fromJson(json.encode(post)));
    }
    return posts;
  }

  Future<List<Comment>> getCommentsForPost(int postId) async {
    var comments = <Comment>[];
    var response;
    try {
      response = await client.get('$endpoint/comments?postId=$postId');
    } catch (e) {
      throw NetworkErrorException();
    }
    if (response.statusCode == 404) {
      throw CommentNotFoundException(postId);
    }
    var parsed = json.decode(response.body) as List<dynamic>;
    for (var comment in parsed) {
      comments.add(Comment.fromJson(json.encode(comment)));
    }
    return comments;
  }
}
