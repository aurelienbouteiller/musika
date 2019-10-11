import 'package:flutter/material.dart';
import 'package:musika/widget/ChoiceButtonWidget.dart';

class ChoiceWidget extends StatelessWidget {
  final titles;
  final onPress;

  ChoiceWidget({this.titles, this.onPress});

  @override
  Widget build(BuildContext context) {
    if (titles.isEmpty) {
      return CircularProgressIndicator();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [titles.elementAt(0), titles.elementAt(1)]
              .map(
                  (title) => ChoiceButtonWidget(title: title, onPress: onPress))
              .toList(),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [titles.elementAt(2), titles.elementAt(3)]
              .map(
                  (title) => ChoiceButtonWidget(title: title, onPress: onPress))
              .toList(),
        ),
      ],
    );
  }
}
