import 'package:flutter/material.dart';
import 'package:musika/widget/ChoiceButtonWidget.dart';

class ChoiceWidget extends StatelessWidget {
  const ChoiceWidget({
    Key key, @required this.titles
  }) : super(key: key);

  final titles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children:
            [titles[0], titles[1]].map((title) => ChoiceButtonWidget(title: title)).toList(),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
            [titles[2], titles[3]].map((title) => ChoiceButtonWidget(title: title)).toList(),
        ),
      ],
    );
  }
}