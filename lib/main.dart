import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musika/SelectLevelPage.dart';
import 'package:musika/style/theme.dart' as Themee;

import 'model/User.dart';

void main() => runApp(MusikaApp());

class MusikaApp extends StatefulWidget {
  @override
  _MusikaAppState createState() => _MusikaAppState();
}

class _MusikaAppState extends State<MusikaApp> {
  Future<FirebaseUser> _userInitialisation() {
    return FirebaseAuth.instance.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Themee.Colors.loginGradientEnd,
        statusBarColor: Colors.transparent));

    return FutureBuilder(
        future: _userInitialisation(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.error != null) {
              print(snapshot.error.toString());
            }

            User user;
            snapshot.hasData
                ? user = User(isConnected: true)
                : user = User(isConnected: false);

            return MaterialApp(
              home: SelectLevelPage(user: user),
              theme: ThemeData(
                  brightness: Brightness.light,
                  primaryColor: Color(0xFFfdcb6e),
                  backgroundColor: Color(0xFFdfe6e9),
                  accentColor: Color(0xFFe17055),
                  dividerColor: Color(0xFFdfe6e9),
                  secondaryHeaderColor: Colors.white),
              darkTheme: ThemeData(
                  brightness: Brightness.dark,
                  primaryColor: Color(0xFF3a4750),
                  backgroundColor: Colors.black,
                  accentColor: Color(0xFFe17055),
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
