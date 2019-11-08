import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musika/SelectLevelPage.dart';
import 'package:musika/StatsPage.dart';

import 'model/User.dart';

void main() => runApp(MusikaApp());

class MusikaApp extends StatefulWidget {
  @override
  _MusikaAppState createState() => _MusikaAppState();
}

class _MusikaAppState extends State<MusikaApp> {
  Future<User> _userInitialisation() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user == null
        ? User(isConnected: false)
        : User(
            uid: user.uid,
            isConnected: true,
            name: user.displayName,
            email: user.email);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return FutureBuilder(
        future: _userInitialisation(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.error != null) {
              print(snapshot.error.toString());
            }

            User user = snapshot.data;

            return MaterialApp(
              home: SelectLevelPage(user: user),
              theme: ThemeData(
                  brightness: Brightness.light,
                  primaryColor: Color(0xFFFDC830),
                  backgroundColor: Color(0xFFdfe6e9),
                  accentColor: Color(0xFFF37335),
                  dividerColor: Color(0xFFdfe6e9),
                  secondaryHeaderColor: Colors.white),
              darkTheme: ThemeData(
                  brightness: Brightness.dark,
                  primaryColor: Color(0xFF3a4750),
                  backgroundColor: Colors.black,
                  accentColor: Color(0xFF3a4750),
                  dividerColor: Colors.white30,
                  secondaryHeaderColor: Colors.white70),
              debugShowCheckedModeBanner: false,
            );
          } else {
            return Center(
                child: Container(
                    child: CircularProgressIndicator(),
                    alignment: Alignment(0.0, 0.0)));
          }
        });
  }
}
