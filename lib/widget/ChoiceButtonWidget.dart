import 'package:flutter/material.dart';

class ChoiceButtonWidget extends StatelessWidget {
  final onPress;
  final title;
  final bool disabled;

  const ChoiceButtonWidget(
      {Key key, @required this.title, this.onPress, this.disabled})
      : super(key: key);

  void onPressed() {
    onPress(title);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      width: 150,
      height: 75,
      child: FlatButton(
        onPressed: disabled ? null : onPressed,
        disabledColor: Colors.black26,
        disabledTextColor: Colors.white,
        color: Color(0xffF5B041),
        child: Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        textColor: Colors.white,
      ),
    );
  }
}
