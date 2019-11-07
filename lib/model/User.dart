import 'Levels.dart';

class User {
  String uid;
  String email;
  String name;
  bool isConnected;
  Levels levels;

  User({this.uid, this.email, this.isConnected, this.name});
}
