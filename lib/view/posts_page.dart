import 'package:demo_state_rebuilder/models/Post.dart';
import 'package:demo_state_rebuilder/services/auth_service.dart';
import 'package:demo_state_rebuilder/view/ui/comments.dart';
import 'package:demo_state_rebuilder/view/ui/common.dart';
import 'package:demo_state_rebuilder/view/ui/like_button.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class CounterData {
  int counter;
  CounterData(this.counter);
}

// 🤔Business Logic
class CounterService {
  final CounterData model;
  CounterService(this.model);

  void incrementMutable() {
    if (model.counter == 2) {
      throw Exception();
    }
    model.counter++;
  }
}

final counterService =
    RM.inject(() => CounterService(CounterData(1)), undoStackLength: 3);

class PostPage extends StatelessWidget {
  PostPage({this.post});
  final Post post;
  //NOTE1: Get the logged user
  final user = Injector.get<AuthService>().user;
  final _counter = counterService.state.model;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: const Text('🏎️ Counter ++'),
                  onPressed: () => counterService.setState(
                    (s) {
                      CounterService s2 = CounterService(s.model);
                      s.incrementMutable();
                      return s2;
                    },
                  ),
                ),
                ElevatedButton(
                  child: const Text('⏱️ Undo'),
                  onPressed: () => counterService.undoState(),
                ),
                counterService.whenRebuilder(
                  onIdle: () => Text('🏁Result: ${_counter.counter}'),
                  onData: () => Text('🏁Result: ${_counter.counter}'),
                  onWaiting: () => Text('wait 🏁Result'),
                  onError: (e) => Text('$e error'),
                ),
              ],
            ),
            Text(post.title, style: headerStyle),
            Text(
              'by ${user.name}',
              style: TextStyle(fontSize: 9.0),
            ),
            UIHelper.verticalSpaceMedium(),
            Text(post.body),
            LikeButton(
              postId: post.id,
            ),
            Comments(post.id)
          ],
        ),
      ),
    );
  }
}
