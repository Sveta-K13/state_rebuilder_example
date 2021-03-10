import 'package:demo_state_rebuilder/models/Post.dart';

import 'interface.dart';

class PostsService {
  IApi _api;
  List<Post> _posts;

  PostsService({IApi api}) : _api = api;

  List<Post> get posts => _posts;

  void getPostsForUser(int userId) async {
    _posts = await _api.getPostsForUser(userId);
  }

//Encapsulation of the logic of getting post likes.
  int getPostLikes(postId) {
    return _posts.firstWhere((post) => post.id == postId).likes;
  }

//Encapsulation of the logic of incrementing the like of a post.
  void incrementLikes(int postId) {
    _posts.firstWhere((post) => post.id == postId).incrementLikes();
  }
}
