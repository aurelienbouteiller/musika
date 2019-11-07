import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musika/authentification/widgets/MenuBar.dart';
import 'package:musika/authentification/widgets/SignIn.dart';
import 'package:musika/authentification/widgets/SignUp.dart';

class AuthenticationPage extends StatefulWidget {
  AuthenticationPage({Key key}) : super(key: key);

  @override
  _AuthenticationPage createState() => _AuthenticationPage();
}

class _AuthenticationPage extends State<AuthenticationPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeName = FocusNode();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  @override
  void dispose() {
    myFocusNodeName.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  switchColors(index) {
    if (index == 0) {
      setState(() {
        right = Colors.white;
        left = Colors.black;
      });
    } else if (index == 1) {
      setState(() {
        right = Colors.black;
        left = Colors.white;
      });
    }
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color accentColor = Theme.of(context).accentColor;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height >= 775.0
              ? MediaQuery.of(context).size.height
              : 775.0,
          decoration: isDark
              ? BoxDecoration(color: Theme.of(context).backgroundColor)
              : BoxDecoration(
                  gradient: LinearGradient(
                      colors: [primaryColor, accentColor],
                      begin: const FractionalOffset(0.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 70.0),
                child: MenuBar(
                    rightColor: right,
                    leftColor: left,
                    pageController: _pageController),
              ),
              Expanded(
                flex: 2,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: switchColors,
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: BoxConstraints.expand(),
                      child: SignIn(
                        scaffoldKey: _scaffoldKey,
                        showInSnackBar: showInSnackBar,
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints.expand(),
                      child: SignUp(
                        auth: _auth,
                        showInSnackBar: showInSnackBar,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
