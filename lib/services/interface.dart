import 'package:demo_state_rebuilder/models/Comment.dart';
import 'package:demo_state_rebuilder/models/Post.dart';
import 'package:demo_state_rebuilder/models/User.dart';

abstract class IApi extends IApiUser {
  Future<List<Post>> getPostsForUser(int userId);
  Future<List<Comment>> getCommentsForPost(int postId);
}

abstract class IApiUser {
  Future<User> getUserProfile(int userId);
}
