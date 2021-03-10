import 'package:demo_state_rebuilder/services/auth_service.dart';
import 'package:demo_state_rebuilder/view/ui/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'ui/login_header.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: backgroundColor,
      body: _LoginBody(),
    );
  }
}

class _LoginBody extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StateBuilder<AuthService>(
      //NOTE1: getting the registered reactiveModel and subscribe to StateBuilder
      observe: () => Injector.getAsReactive<AuthService>(),
      //Note2: disposing TextEditingController to free resources.
      dispose: (_, __) => controller.dispose(),
      builder: (_, authServiceRM) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginHeader(
              // //NOTE3: ErrorHandler is a class method used to center error handling.
              // //NOTE4: errorMessage returns a string description of the thrown error if there is one.
              // //NOTE4: because we are handling error we must catch them is setState method.
              validationMessage: ErrorHandler.errorMessage(authServiceRM.error),
              controller: controller,
            ),
            //NOTE5: if authServiceRM ReactiveModel if it is waiting.
            authServiceRM.isWaiting
                ? CircularProgressIndicator()
                : TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      //NOTE6: call setState method
                      authServiceRM.setState(
                        (state) => state.login(controller.text),
                        //NOTE7: catchError
                        catchError: true,
                        //NOTE8: Check if user is logged (authServiceRM has data) and navigate to home page
                        onData: (context, authServiceRM) {
                          Navigator.pushNamed(context, '/');
                          //We can use pushReplacementNamed without problem because
                          //AuthenticationService is injected globally before MaterialApp
                        },
                      );
                    },
                  )
          ],
        );
      },
    );
  }
}
