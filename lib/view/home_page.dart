import 'package:demo_state_rebuilder/models/Post.dart';
import 'package:demo_state_rebuilder/services/auth_service.dart';
import 'package:demo_state_rebuilder/services/post_service.dart';
import 'package:demo_state_rebuilder/view/ui/common.dart';
import 'package:demo_state_rebuilder/view/ui/post_list_item.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class HomePage extends StatelessWidget {
  //NOTE1: In the login page we instantiated the user and navigated to this page.
  //NOTE1: We use Injector.get to access AuthenticationService and get user.
  final user = Injector.get<AuthService>().user;
  @override
  Widget build(BuildContext context) {
    return Injector(
        //NOTE2: Inject PostsService
        inject: [Inject(() => PostsService(api: Injector.get()))],
        builder: (context) {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: StateBuilder<PostsService>(
              observe: () => Injector.getAsReactive<PostsService>(),
              initState: (_, postsServiceRM) {
                //NOTE3: get the list of post from the user id
                postsServiceRM.setState(
                  (state) => state.getPostsForUser(user.id),
                  //NOTE3: Delegate error handling to the ErrorHandler to show an alertDialog
                  // onError: ErrorHandler.showErrorDialog,
                );
              },
              builder: (_, postsService) {
                //NOTE4: isIdle is unreachable status because the setState is called from the initState

                //NOTE4: check if waiting
                if (postsService.isWaiting) {
                  return Center(child: CircularProgressIndicator());
                }

                //NOTE4: hasData and hasError (posts=[] so no problem to display empty posts)
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UIHelper.verticalSpaceLarge(),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Welcome ${user.name}',
                        style: headerStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text('Here are all your posts',
                          style: subHeaderStyle),
                    ),
                    UIHelper.verticalSpaceSmall(),
                    Expanded(child: getPostsUi(postsService.state.posts)),
                  ],
                );
              },
            ),
          );
        });
  }

  //List of posts
  Widget getPostsUi(List<Post> posts) => ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) => PostListItem(
          post: posts[index],
          onTap: () {
            //Navigate to poste detail
            Navigator.pushNamed(context, 'post', arguments: posts[index]);
            //If you use pushReplacementNamed, PostsService will be unregistered and
            //You can not get it using Injector.get or Injector.getAsReactive.
            //If you want keep PostsService you have to reinject it. See not bellow.
          },
        ),
      );
}
