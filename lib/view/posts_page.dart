import 'package:demo_state_rebuilder/models/Post.dart';
import 'package:demo_state_rebuilder/services/auth_service.dart';
import 'package:demo_state_rebuilder/view/ui/comments.dart';
import 'package:demo_state_rebuilder/view/ui/common.dart';
import 'package:demo_state_rebuilder/view/ui/like_button.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class PostPage extends StatelessWidget {
  PostPage({this.post});
  final Post post;
  //NOTE1: Get the logged user
  final user = Injector.get<AuthService>().user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UIHelper.verticalSpaceLarge(),
            Text(post.title, style: headerStyle),
            //NOTE2: Display user name
            Text(
              'by ${user.name}',
              style: TextStyle(fontSize: 9.0),
            ),
            UIHelper.verticalSpaceMedium(),
            Text(post.body),
            //NOTE3: like button widget (like_button.dart)
            LikeButton(
              postId: post.id,
            ),
            //NOTE3: Comments widget (comments.dart)
            Comments(post.id)
          ],
        ),
      ),
    );
  }
}
