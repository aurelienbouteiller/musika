import 'package:flutter/material.dart';

class ChoiceButtonWidget extends StatelessWidget {
  final onPress;
  final title;

  const ChoiceButtonWidget({Key key, @required this.title, this.onPress})
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
        onPressed: onPressed,
        color: Color(0xffF5B041),
        child: Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5)),
        textColor: Colors.white,
      ),
    );
  }
}
