import 'package:demo_state_rebuilder/view/home_page.dart';
import 'package:demo_state_rebuilder/view/login_page.dart';
import 'package:demo_state_rebuilder/view/posts_page.dart';
import 'package:flutter/material.dart';

import 'models/Post.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginPage());

      case 'post':
        var post = settings.arguments as Post;
        return MaterialPageRoute(
          builder: (_) => PostPage(post: post),
        );
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
