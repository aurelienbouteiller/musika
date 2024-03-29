import 'package:flutter/material.dart';
import 'package:musika/widget/ChoiceButtonWidget.dart';

class ChoiceWidget extends StatelessWidget {
  final List<String> titles;
  final onPress;
  final bool disabled;
  final bool answered;
  final int selectedTitleIndex;
  final int chosenTitleIndex;

  ChoiceWidget(
      {this.titles,
      this.onPress,
      this.disabled,
      this.answered,
      this.selectedTitleIndex,
      this.chosenTitleIndex});

  choiceColorForIndex(context, choiceIndex) => answered
      ? chosenTitleIndex == choiceIndex
          ? selectedTitleIndex == choiceIndex ? Colors.green : Colors.red
          : selectedTitleIndex == choiceIndex ? Colors.green : Colors.grey
      : Theme.of(context).primaryColor;

  @override
  Widget build(BuildContext context) {
    if (titles.isEmpty) {
      return CircularProgressIndicator();
    }
    var choiceIndex = 0;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: titles
                .getRange(0, 2)
                .map((title) => ChoiceButtonWidget(
                    title: title,
                    onPress: onPress,
                    disabled: disabled,
                    color: choiceColorForIndex(context, choiceIndex++)))
                .toList(),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: titles
                .getRange(2, 4)
                .map((title) => ChoiceButtonWidget(
                    title: title,
                    onPress: onPress,
                    disabled: disabled,
                    color: choiceColorForIndex(context, choiceIndex++)))
                .toList(),
          ),
        ],
      ),
    );
  }
}
