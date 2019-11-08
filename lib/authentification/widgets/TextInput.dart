import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TextInput extends StatefulWidget {
  final IconData icon;
  final String label;
  final Function validator;
  bool isPassword;
  final Function onSaved;

  TextInput(
      {@required this.icon,
      @required this.label,
      this.onSaved,
      this.validator,
      this.isPassword = false});

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool inputHidden = true;

  @override
  void initState() {
    super.initState();
    if (widget.isPassword) {
      inputHidden = false;
    }
  }

  void togglePasswordVisibility() {
    setState(() {
      inputHidden = !inputHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextFormField(
        validator: widget.validator,
        keyboardType: TextInputType.text,
        obscureText: !inputHidden,
        textCapitalization: TextCapitalization.words,
        style: TextStyle(
            fontFamily: "WorkSansSemiBold",
            fontSize: 16.0,
            color: Colors.black),
        onSaved: widget.onSaved,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            widget.icon,
            color: Colors.black,
          ),
          hintText: this.widget.label,
          hintStyle: TextStyle(
              color: Colors.black54,
              fontFamily: "WorkSansSemiBold",
              fontSize: 16.0),
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: togglePasswordVisibility,
                  child: Icon(
                    !inputHidden
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash,
                    size: 15.0,
                    color: Colors.black,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
