import 'package:flutter/material.dart';

class ArtistWidget extends StatefulWidget {
  const ArtistWidget({Key key, this.artistName, this.imageUrl})
      : super(key: key);

  final String artistName;
  final String imageUrl;

  @override
  _ArtistWidgetState createState() => _ArtistWidgetState();
}

const INITIAL_WIDTH = 120.0;

class _ArtistWidgetState extends State<ArtistWidget> {
  double containerWidth = INITIAL_WIDTH;

  changeContainerWidth(detail) {
    var x = detail.localPosition.dx;
    if (x > INITIAL_WIDTH && x < 250) {
      setState(() {
        containerWidth = x;
      });
    }
  }

  resetAndGoBack(detail) {
    if (containerWidth > 200) {
      Future.delayed(Duration(milliseconds: 100), () => Navigator.pop(context));
    }

    setState(() {
      containerWidth = 120;
    });
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onHorizontalDragUpdate: changeContainerWidth,
            onHorizontalDragEnd: resetAndGoBack,
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                alignment: Alignment.centerRight,
                width: containerWidth,
                height: 140,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xffBE5A38),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(widget.imageUrl),
                    ),
                    Text(
                      widget.artistName,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        color: Color(0xFFF7EDDC),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
