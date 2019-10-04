import 'package:flutter/material.dart';

class ChoiceButtonWidget extends StatelessWidget {
  const ChoiceButtonWidget({
    Key key,@required this.title
  }) : super(key: key);

  final title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      width: 150,
      height: 75,
      child: FlatButton(
        onPressed: (){/**/},
        color: Color(0xffF5B041),
        child: Text(
            title
        ),
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5)),
        textColor: Colors.white,
      ),
    );
  }
}