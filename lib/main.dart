import 'package:demo_state_rebuilder/services/api.dart';
import 'package:demo_state_rebuilder/services/auth_service.dart';
import 'package:demo_state_rebuilder/services/interface.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'router.dart' as router;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Injector(
        inject: [
          Inject<IApi>(() => Api()),
          Inject(() => AuthService(api: Injector.get())),
        ],
        builder: (context) => MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              initialRoute: 'login',
              onGenerateRoute: router.Router.generateRoute,
            ));
  }
}
