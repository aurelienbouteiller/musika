import 'package:flutter/material.dart';

class ChoiceButtonWidget extends StatelessWidget {
  final onPress;
  final title;
  final bool disabled;
  final Color color;
  final bool answered;

  const ChoiceButtonWidget(
      {Key key,
      @required this.title,
      this.onPress,
      this.disabled,
      this.answered,
      @required this.color})
      : super(key: key);

  void onPressed() {
    onPress(title);
  }

  Paint _coloredAnswer(BuildContext context)
  {
    Rect rectForShader = Rect.fromLTWH(0.0, 0.0, 300.0, 70.0);
    Shader linearGradientShader = LinearGradient(colors: [
      Theme.of(context).primaryColor,
      Theme.of(context).accentColor
    ]).createShader(rectForShader);

    if (answered)
      {
        return Paint()..color = Colors.white;
      }
    else
      {
        return Paint()..shader = linearGradientShader;
      }
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
          style: TextStyle(
            foreground: _coloredAnswer(context),
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
