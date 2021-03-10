import 'package:demo_state_rebuilder/models/Comment.dart';

import 'interface.dart';

class CommentsService {
  IApi _api;
  List<Comment> _comments;
  CommentsService({IApi api}) : _api = api;

  List<Comment> get comments => _comments;
  Future<void> fetchComments(int postId) async {
    _comments = await _api.getCommentsForPost(postId);
  }
}
