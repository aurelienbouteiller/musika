import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musika/model/User.dart';

import '../../SelectLevelPage.dart';
import 'TextInput.dart';

class SignUp extends StatefulWidget {
  final auth;
  final Function showInSnackBar;

  SignUp({this.auth, this.showInSnackBar});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> formKeySignUp = GlobalKey<FormState>();
  final GlobalKey<FormState> _containerKeySignUp = GlobalKey<FormState>();
  String _nameSignUp, _emailSignUp, _passwordSignUp;

  void _signUp(context) async {
    final _formState = formKeySignUp.currentState;
    if (_formState.validate()) {
      _formState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: _emailSignUp, password: _passwordSignUp))
            .user;
        UserUpdateInfo updateInfo = UserUpdateInfo();
        updateInfo.displayName = _nameSignUp;

        await user.updateProfile(updateInfo);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => SelectLevelPage(
                    user: User(
                        name: user.displayName,
                        email: user.email,
                        isConnected: true,
                        uid: user.uid))),
            (_) => false);
      } catch (e) {
        widget.showInSnackBar("Inscription refusé");
        print(e.message);
      }
    }
  }

  String mailValidator(input) {
    if (input.isEmpty) {
      return 'Renseignez une adresse mail';
    }
    return null;
  }

  String passwordValidator(input) {
    if (input.length < 6) {
      return 'Veuillez choisir un mot de passe plus long';
    }
    return null;
  }

  String confirmPasswordValidator(input) {
    if (input.length < 6) {
      return 'Longer password please';
    }
    return null;
  }

  void onNameSaved(input) {
    _nameSignUp = input;
  }

  void onMailSaved(input) {
    _emailSignUp = input;
  }

  void onPasswordSaved(input) {
    _passwordSignUp = input;
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color accentColor = Theme.of(context).accentColor;

    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Form(
            key: formKeySignUp,
            child: Container(
              key: _containerKeySignUp,
              child: Stack(
                alignment: Alignment.topCenter,
                overflow: Overflow.visible,
                children: <Widget>[
                  Card(
                    elevation: 2.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      width: 300.0,
                      height: 360.0,
                      child: Column(
                        children: <Widget>[
                          TextInput(
                            icon: FontAwesomeIcons.user,
                            label: "Nom",
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          TextInput(
                            icon: FontAwesomeIcons.envelope,
                            label: "Adresse mail",
                            validator: mailValidator,
                            onSaved: onMailSaved,
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          TextInput(
                            icon: FontAwesomeIcons.lock,
                            label: "Mot de passe",
                            validator: passwordValidator,
                            isPassword: true,
                            onSaved: onPasswordSaved,
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          TextInput(
                            icon: FontAwesomeIcons.lock,
                            label: "Confirmation",
                            validator: confirmPasswordValidator,
                            isPassword: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 340.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: primaryColor,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 20.0,
                        ),
                        BoxShadow(
                          color: accentColor,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 20.0,
                        ),
                      ],
                      gradient: LinearGradient(
                          colors: [accentColor, primaryColor],
                          begin: const FractionalOffset(0.2, 0.2),
                          end: const FractionalOffset(1.0, 1.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: MaterialButton(
                        highlightColor: Colors.transparent,
                        splashColor: accentColor,
                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontFamily: "WorkSansBold"),
                          ),
                        ),
                        onPressed: () => _signUp(context)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
