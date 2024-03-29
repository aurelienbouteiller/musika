import 'package:flutter/material.dart';

class ChoiceButtonWidget extends StatelessWidget {
  final onPress;
  final title;
  final bool disabled;
  final Color color;

  const ChoiceButtonWidget(
      {Key key,
      @required this.title,
      this.onPress,
      this.disabled,
      @required this.color})
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
      child: MaterialButton(
        elevation: 3,
        onPressed: disabled ? null : onPressed,
        disabledColor: color,
        disabledTextColor: Colors.white,
        color: color,
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
