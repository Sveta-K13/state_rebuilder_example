import 'package:demo_state_rebuilder/models/User.dart';

import 'common.dart';
import 'interface.dart';

class AuthService {
  IApi _api;
  User _fetchedUser;

  AuthService({IApi api}) : _api = api;

  User get user => _fetchedUser;

  void login(String userIdText) async {
    //Delegate the input parsing and validation
    var userId = InputParser.parse(userIdText);
    _fetchedUser = await _api.getUserProfile(userId);
    //// TODO1 : throw unhandled exception
    ////TODO2: Instantiate a value object in a bad state.
    ////TODO3: try to persist an entity is bad state.
  }
}
