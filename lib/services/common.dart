import 'exceptions.dart';

class InputParser {
  static int parse(String userIdText) {
    var userId = int.tryParse(userIdText);
    if (userId == null) {
      throw NotNumberException();
    }
    return userId;
  }
}
